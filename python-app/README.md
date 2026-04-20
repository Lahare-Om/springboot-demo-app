# Python Demo App

A simple FastAPI-based Python microservice for local Docker/K8s/ArgoCD exercises.

## Overview

This is a demo Python application that can be deployed alongside the Spring Boot application. It provides a set of simple REST API endpoints for testing and demonstration purposes.

## Project Structure

```
python-app/
├── app/
│   ├── __init__.py
│   └── main.py          # FastAPI application
├── tests/
│   ├── __init__.py
│   └── test_main.py     # Unit tests
├── requirements.txt     # Python dependencies
├── Dockerfile          # Container image definition
├── .dockerignore        # Docker build exclusions
├── .gitignore          # Git exclusions
└── README.md           # This file
```

## Quick Start

### Local Development

1. **Create a virtual environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the application**:
   ```bash
   python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   ```

4. **Access the API**:
   - API: http://localhost:8000
   - Docs: http://localhost:8000/docs

### Docker

Build and run with Docker:

```bash
# Build image
docker build -t python-demo-app:0.1.0 .

# Run container
docker run -p 8000:8000 python-demo-app:0.1.0
```

Access at http://localhost:8000

## API Endpoints

### Health & Info

- **GET** `/` - Root endpoint, returns status message
- **GET** `/health` - Health check endpoint
- **GET** `/api/info` - Application information

### Utility Endpoints

- **GET** `/api/echo/{message}` - Echo back a message with timestamp

## Testing

Run unit tests:

```bash
pytest tests/
```

Run with coverage:

```bash
pytest --cov=app tests/
```

## Dependencies

- **FastAPI** - Modern web framework for building APIs
- **Uvicorn** - ASGI server for running FastAPI
- **Pydantic** - Data validation using Python type annotations
- **Pytest** - Testing framework

## Development

### Adding Endpoints

Edit `app/main.py` and add new route handlers:

```python
@app.get("/api/your-endpoint")
async def your_endpoint():
    return {"result": "your data"}
```

### Running Tests

```bash
pytest tests/
```

## Deployment

### Docker Compose

Can be deployed alongside the Spring Boot app using docker-compose.

### Kubernetes

Use the K8s configurations in the `k8s/` directory at the root of the repository.

### ArgoCD

Deployed via ArgoCD configurations in the `argocd/` directory.

## Environment Variables

Currently no environment variables are required. The app listens on port 8000.

## Version

- **App Version**: 0.1.0
- **Python**: 3.11+
- **FastAPI**: 0.104.1+

## License

See LICENSE in the root directory.
