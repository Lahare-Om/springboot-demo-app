"""Tests for FastAPI application."""
import pytest
from fastapi.testclient import TestClient
from app.main import app


@pytest.fixture
def client():
    """Create a test client."""
    return TestClient(app)


def test_root(client):
    """Test root endpoint."""
    response = client.get("/")
    assert response.status_code == 200
    assert "message" in response.json()
    assert response.json()["message"] == "Python demo app is running"


def test_health(client):
    """Test health check endpoint."""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["service"] == "python-demo-app"


def test_info(client):
    """Test info endpoint."""
    response = client.get("/api/info")
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "python-demo-app"
    assert "version" in data
    assert "description" in data


def test_echo(client):
    """Test echo endpoint."""
    test_message = "hello world"
    response = client.get(f"/api/echo/{test_message}")
    assert response.status_code == 200
    data = response.json()
    assert data["original"] == test_message
    assert data["echoed"] == test_message
    assert "timestamp" in data
