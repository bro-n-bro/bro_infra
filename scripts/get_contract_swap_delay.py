"""
How to use:
Use python 3+
pip install clickhouse_connect
pip install websocket
pip install rel
Replace everything start with <ENTER... with real value
Run `python get_blocks_delay.py`
"""
import json
from datetime import datetime

import clickhouse_connect
import websocket
import rel


def calculate_delay(block_number, contract_address, start_time):
    while True:
        query_response = clickhouse_client.query(
            f"select * from spacebox.wasm_swaps where height = {block_number} and contract_address='{contract_address}'"
        ).result_rows
        if len(query_response):
            break
        if (datetime.now() - start_time).total_seconds() > 10:
            print(f'GAP for block {block_number}, contract_address {contract_address}: MORE THAN 10 SECONDS')
            break
    print(f'GAP for block {block_number}, contract_address {contract_address}:')
    print(datetime.now() - start_time)


def on_message(ws, message):
    message = json.loads(message)
    webhook_received = datetime.now()
    if events := message.get('result', {}).get('data', {}).get('value', {}).get('TxResult', {}).get('result', {}).get('events', []):
        needed_event = next((event for event in events if event.get('type') == 'wasm'), None)
        if needed_event:
            event_action = next((item for item in needed_event['attributes'] if item['key'] == 'action'), {})
            if event_action.get('value') == 'swap':
                block_number = message.get('result', {}).get('data', {}).get('value', {}).get('TxResult', {}).get('height', None)
                contract_address = next((attribute['value'] for attribute in needed_event['attributes'] if attribute['key'] == '_contract_address'), None)
                if not block_number or not contract_address:
                    print(f'No block number {block_number} or no contract_address {contract_address}')
                else:
                    print('CHECK')
                    print(block_number)
                    print(contract_address)
                    calculate_delay(block_number, contract_address, webhook_received)


def on_error(ws, error):
    print(error)


def on_close(ws, close_status_code, close_msg):
    print("### closed ###")


def on_open(ws):
    print("Opened connection")
    ws.send(json.dumps({
        "jsonrpc": "2.0",
        "method": "subscribe",
        "id": "0",
        "params": {
            "query": "message.action='/cosmwasm.wasm.v1.MsgExecuteContract'"
        }
    }))
    print("send subscription successfully")


if __name__ == "__main__":
    websocket.enableTrace(False)
    clickhouse_client = clickhouse_connect.get_client(
        host='<ENTER_HOST>',
        port='<ENTER_PORT>',
        username='<ENTER_USERNAME>',
        password='<ENTER_PASSWORD>',
        secure=False
    )
    ws = websocket.WebSocketApp('<ENTER_WEBSOCKET_URL>',
                              on_open=on_open,
                              on_message=on_message,
                              on_error=on_error,
                              on_close=on_close)
    ws.run_forever(dispatcher=rel, reconnect=5)  # Set dispatcher to automatic reconnection, 5 second reconnect delay if connection closed unexpectedly
    rel.signal(2, rel.abort)  # Keyboard Interrupt
    rel.dispatch()
