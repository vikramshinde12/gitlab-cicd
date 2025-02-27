from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to FastAPI!"}


def test_greet():
    name = "Vikram"
    response = client.get(f"/greet/{name}")
    assert response.status_code == 200
    assert response.json() == {"greeting": f"Hello, {name}!"}


def test_read_item_with_query():
    response = client.get("/items/42?q=fastapi")
    assert response.status_code == 200
    assert response.json() == {"item_id": 42, "query": "fastapi"}


def test_read_item_without_query():
    response = client.get("/items/99")
    assert response.status_code == 200
    assert response.json() == {"item_id": 99, "query": None}
