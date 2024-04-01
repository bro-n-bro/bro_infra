"""
pip install asyncio
pip install aiohttp
pip install aiochclient
set real values for DB_URL and NEUTRON_LCD_API

python3 check_addresses.py
"""

import asyncio
from aiohttp import ClientSession
from aiochclient import ChClient

DB_URL = ''
NEUTRON_LCD_API = ''

def get_raw_query(address):
    return f"""
        select saldo as amount, denom from (
        WITH ranked_saldo AS (
        SELECT
            denom,
            saldo,
            height,
            ROW_NUMBER() OVER (PARTITION BY denom
        ORDER BY
            height DESC) AS rn
        FROM
            (
                WITH account_debs AS (
                    SELECT * FROM spacebox.debs_and_creds
                    WHERE address = '{address}'
                    UNION ALL 
                    SELECT * FROM spacebox.genesis_balances
                    WHERE address = '{address}'
                )
            SELECT 
                    height,
                    amount,
                    sum(amount) over (partition by denom
            order by
                height) as saldo, 
                    denom
            FROM
                account_debs
            )
        )
        SELECT
            height,
            saldo,
            denom
        FROM
            ranked_saldo
        WHERE
            rn = 1 and saldo != 0
        )
    """


RANDOM_ADDRESSES_QUERY = """
    select * from (
    select DISTINCT(signer) from spacebox.raw_transaction 
    ) ORDER BY RAND() limit 100 
"""

async def some_query(client, sql):
    all_rows = await client.fetch(sql, json=True)
    return all_rows


async def get_http(session, address):
    async with session.get(f'{NEUTRON_LCD_API}{address}') as resp:
        return await resp.json()


def compare_date(tasks, address):
    http_result = tasks[0].result()['balances']
    sql_result = tasks[1].result()
    is_equal = sorted(http_result, key=lambda d: sorted(d.items())) == sorted(sql_result, key=lambda d: sorted(d.items()))
    if not is_equal:
        print(f'Not equal value for address: {address}')
    else:
        print(f'Everything is ok for address: {address}')

async def compete():

    async with ClientSession() as session:
        my_client = ChClient(session, url=DB_URL)
        addresses = [address['signer'] for address in await some_query(my_client, RANDOM_ADDRESSES_QUERY)]
        for address in addresses:
            tasks = []
            http_task = asyncio.create_task(get_http(session, address))
            sql_task = asyncio.create_task(some_query(my_client, get_raw_query(address)))
            tasks.append(http_task)
            tasks.append(sql_task)
            await asyncio.gather(*tasks)
            compare_date(tasks, address)

asyncio.run(compete())
