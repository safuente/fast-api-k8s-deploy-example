from fastapi import FastAPI

app = FastAPI()

@app.get('/')
async def hello_world():
    return {
        'status': 'OK',
        'msg': 'Hello world!'
    }
