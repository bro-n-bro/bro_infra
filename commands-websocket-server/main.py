import subprocess
import uvicorn
from fastapi import FastAPI, WebSocket
import config

app = FastAPI()


def run_command(command):
    p = subprocess.Popen(command,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.STDOUT)
    return iter(p.stdout.readline, b'')


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        command = config.COMMANDS_MATCHER.get(data, None)
        if not command:
            await websocket.send_text("INVALID_COMMAND")
        else:
            for line in run_command(command):
                line = " ".join(line.decode().split())
                await websocket.send_text(line)
            await websocket.send_text("FINISHED")


if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8000)
