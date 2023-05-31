# test hello_world_api.py
from fastapi.testclient import TestClient
from python_api.main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200

def test_hello_world():
    response = client.get("/hello_world")
    assert response.status_code == 200
    assert response.json() == 'Hello, World! This is your new project!'
