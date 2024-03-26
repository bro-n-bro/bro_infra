import random

import uvicorn
from fastapi import FastAPI

app = FastAPI()


@app.get("/one/")
def read_networks():
    return {'success': bool(random.getrandbits(1))}


@app.get("/two/")
def read_networks():
    return {'success': bool(random.getrandbits(1))}


@app.get("/three/")
def read_networks():
    return {'success': bool(random.getrandbits(1))}


@app.get("/four/")
def read_networks():
    return {'success': bool(random.getrandbits(1))}


@app.get("/five/")
def read_networks():
    return {'success': bool(random.getrandbits(1))}


@app.get("/six/")
def read_networks():
    return {'success': bool(random.getrandbits(1))}


if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8000)
