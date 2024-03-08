# Spacebox block processing speed check

Allows to check how fast [spacebox indexer](https://github.com/bro-n-bro/spacebox) process blocks. Subscribes to new block from the node, and check the delay between the moment of a new block generation in the chain and the moment of its appearance in the raw_block table in clickhouse.
## How to use:

Python v3+ required

Install some necessasy dependencies: 

```bash
pip install clickhouse_connect
pip install websocket-client==1.7.0
pip install rel
```

Fill out node api and spacebox clickhouse database details by replacing everything starting with `<ENTER...` with real value.

Run:

`python3 get_blocks_delay.py`
