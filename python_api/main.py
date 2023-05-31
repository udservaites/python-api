'''hello world module docstring'''
from fastapi import FastAPI
from pydantic import BaseModel

from python_api.utils import array_add, hello_world


class Item(BaseModel):
    '''class docstring'''
    name: str
    description: str = "Give arrary in form of string. example: '1 2 3 4'. "
    arrary1: str
    arrary2: str


# start api application
app = FastAPI(title="Python API", description="A template project for Python API", version="1.0")


# endpoint to test server health
@app.get("/health")
async def get_health():
    '''get health docstring'''
    return {'message': 'Everything is A-OK'}


# endpoint to hello world
@app.get("/hello_world")
async def get_hello():
    '''get hello docstring'''
    return hello_world()


# endpoint to numpy add
@app.post("/numpy_add")
async def post_numpy(item: Item):
    '''post numpy docstring'''
    return array_add(item.arrary1, item.arrary2)
