from config import NETWORKS


import time
import aiohttp
import asyncio


async def get_network_data(session, network):
    start = time.time()
    tasks = [asyncio.ensure_future(get_delegations(session, network))]
    data = await asyncio.gather(*tasks)
    stop = time.time()
    print(network['name'], stop - start)
    return data


async def get_delegations(session, network):
    url = f"{network['lcd_api']}/staking/validators/{network['validator']}/delegations?limit=1000000"
    async with session.get(url) as resp:
        resp = await resp.json()
        delegations = resp['result']
        tokens = sum([int(d['balance']['amount']) for d in delegations]) / network['exponent']
        return tokens


async def get_data():
    async with aiohttp.ClientSession() as session:
        tasks = []
        for network in NETWORKS:
            tasks.append(asyncio.ensure_future(get_network_data(session, network)))
        networks = await asyncio.gather(*tasks)


if __name__ == "__main__":
    asyncio.run(get_data())
