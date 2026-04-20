# Elixir App

A simple Elixir/Plug-Cowboy web application for testing the pipeline.

## Build
```bash
mix deps.get
mix escript.build
```

## Run
```bash
mix run --no-halt
```

## Endpoints
- `GET /` - Returns a greeting message
- `GET /health` - Health check endpoint
