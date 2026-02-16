# Spring Boot Demo App (Local Docker/K8s/ArgoCD testing)

This folder contains a small **Spring Boot** web application intended to support local testing of:
- Docker containerization (port **8080**)
- Local Kubernetes deployment (Kind/Minikube)
- GitOps-style deployment via Argo CD

It also includes a small **React** UI (Vite) that exercises the API and Actuator health endpoints.

## Endpoints

- **Web UI**
  - `GET /` → React UI

- **App APIs**
  - `GET /api/hello` → basic response
  - `GET /api/time` → current server time
  - `POST /api/echo` → echoes request body
  - `GET /api/env` → shows selected environment variables (safe subset)

- **Actuator**
  - `GET /actuator/health`
  - `GET /actuator/health/liveness`
  - `GET /actuator/health/readiness`
  - `GET /actuator/info`

## Build and run (Docker)

From the repo root:

```bash
docker build -t springboot-demo-app:local ./springboot-demo-app
docker run --rm -p 8080:8080 springboot-demo-app:local
```

Test:

```bash
curl http://localhost:8080/api/hello
curl http://localhost:8080/actuator/health
```

Open the UI:

```bash
start http://localhost:8080/
```

## Local dev (React hot reload)

Run Spring Boot on 8080 (any method you prefer), then run the React dev server on 5173:

```bash
cd springboot-demo-app/frontend
npm install
npm run dev
```

The dev server proxies `/api/*` and `/actuator/*` to `http://localhost:8080`.

## Deploy locally (Kind)

Create a cluster (example):

```bash
kind create cluster
```

Load the locally-built image into Kind:

```bash
kind load docker-image springboot-demo-app:local
```

Apply manifests:

```bash
kubectl apply -f ./springboot-demo-app/k8s
```

Port-forward:

```bash
kubectl port-forward svc/springboot-demo-app 8080:8080
```

## Deploy locally (Minikube)

```bash
minikube start
minikube image load springboot-demo-app:local
kubectl apply -f ./springboot-demo-app/k8s
kubectl port-forward svc/springboot-demo-app 8080:8080
```

## Notes
- The app listens on **8080**.
- Probes are configured for `/actuator/health/liveness` and `/actuator/health/readiness`.
- This app is intentionally simple; it’s a stable target for deployment automation exercises.

