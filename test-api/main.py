from fastapi import FastAPI
from datetime import datetime

app = FastAPI()

@app.get('/')
async def hello_world():
    return {
        'status': 'OK',
        'msg': 'Hello world!'
    }