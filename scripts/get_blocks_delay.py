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
import _thread
import time
import rel


def calculate_delay(block_number, start_time):
    while True:
        last_height_in_db = clickhouse_client.query("select max(height) from spacebox.raw_block rb ").result_rows[0][0]
        if last_height_in_db >= block_number:
            break
    print(f'GAP for block {block_number}:')
    print(datetime.now() - start_time)


def on_message(ws, message):
    message = json.loads(message)
    webhook_received = datetime.now()
    if message.get('result', {}).get('data', {}).get('type') == 'tendermint/event/NewBlock':
        block_number = int(message.get('result', {}).get('data', {}).get('value').get('block').get('header').get('height'))
        calculate_delay(block_number, webhook_received)


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
            "query": "tm.event='NewBlock'"
        }
    }))
    print("send subscription successfully")


if __name__ == "__main__":
    websocket.enableTrace(False)
    clickhouse_client = clickhouse_connect.get_client(
        host='<ENTER_HOST>',
        port='<ENTER_PORT>',
        username='<ENTER_USERNAME>',
        password='<ENTER_PASSWORD>'
    )
    ws = websocket.WebSocketApp('<ENTER_WEBSOCKET_URL>',
                              on_open=on_open,
                              on_message=on_message,
                              on_error=on_error,
                              on_close=on_close)
    ws.run_forever(dispatcher=rel, reconnect=5)  # Set dispatcher to automatic reconnection, 5 second reconnect delay if connection closed unexpectedly
    rel.signal(2, rel.abort)  # Keyboard Interrupt
    rel.dispatch()
