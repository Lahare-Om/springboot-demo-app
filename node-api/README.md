# Node Demo App

A small zero-dependency Node.js API for testing multi-app Docker, Kubernetes, and Argo CD pipelines.

## Endpoints

- `GET /health`
- `GET /api/info`
- `GET /api/echo/:message`

## Local run

```bash
node src/server.js
```

## Tests

```bash
node --test
```
