# PHP App

A simple PHP web application for testing the pipeline.

## Run with Docker
```bash
docker build -t php-app .
docker run -p 8080:8080 php-app
```

## Endpoints
- `GET /` - Returns a greeting message
- `GET /health` - Health check endpoint
