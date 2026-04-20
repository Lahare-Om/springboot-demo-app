# Spring Boot Demo App – Local Docker, Kubernetes & Argo CD GitOps Demo

This repository contains a **Spring Boot + React + Python microservice application** used to demonstrate a **local DevOps and GitOps deployment pipeline**.

The project shows how **multiple containerized applications** can be deployed locally using:

* **Docker** for containerization
* **Kubernetes (Kind / Minikube)** for orchestration
* **Argo CD** for GitOps-based deployments
* **React (Vite)** for the frontend UI
* **Python (FastAPI)** for additional microservices

The goal is to simulate a **real-world multi-service deployment workflow entirely on a developer laptop**.

---

# Architecture

The system demonstrates a **GitOps deployment pipeline** where the Kubernetes cluster state is controlled by Git.

```
Developer
   │
   ▼
GitHub Repository
   │
   ▼
Argo CD (GitOps Controller)
   │
   ▼
Kubernetes Cluster (Kind / Minikube)
   │
   ▼
Deployments
   │
   ▼
Pods (Spring Boot + Python)
   │
   ▼
Services
   │
   ▼
Browser / API Client
```

### Application Architecture

```
React UI
   │
   ▼
Spring Boot API (Port 8080)
   │
   ▼
Python API (Port 8000)
   │
   ▼
Docker Containers
   │
   ▼
Kubernetes Pods
```

---

# Technologies Used

* Java 21
* Spring Boot
* Python 3.11+
* FastAPI
* React (Vite)
* Docker
* Kubernetes
* Kind / Minikube
* Argo CD
* kubectl

---

# Application Endpoints

### Web UI

```
GET /
```

Returns the React UI.

---

### Spring Boot APIs (Port 8080)

```
GET /api/hello
```

Returns a simple greeting response.

```
GET /api/time
```

Returns the current server time.

---

### Python APIs (Port 8000)

```
GET /health
```

Returns health check status.

```
GET /api/info
```

Returns application information.

```
GET /api/echo/{message}
```

Echoes back the provided message with timestamp.

```
POST /api/echo
```

Echoes the request body.

```
GET /api/env
```

Returns selected environment variables (safe subset).

---

### Spring Boot Actuator

```
GET /actuator/health
GET /actuator/health/liveness
GET /actuator/health/readiness
GET /actuator/info
```

These endpoints are used by Kubernetes health probes.

---

# Build and Run (Docker)

From the repository root:

```bash
docker build -t springboot-demo-app:local ./springboot-demo-app
docker run --rm -p 8080:8080 springboot-demo-app:local
```

Test the API:

```bash
curl http://localhost:8080/api/hello
curl http://localhost:8080/actuator/health
```

Open the UI:

```
http://localhost:8080
```

---

# Local Development (React Hot Reload)

Run the Spring Boot backend first (any method).

Then start the React dev server:

```bash
cd springboot-demo-app/frontend
npm install
npm run dev
```

The dev server runs on:

```
http://localhost:5173
```

API requests are proxied to:

```
http://localhost:8080
```

---

# Deploy Locally with Kubernetes (Kind)

Create a Kubernetes cluster:

```bash
kind create cluster
```

Load the Docker image into the cluster:

```bash
kind load docker-image springboot-demo-app:local
```

Deploy the application:

```bash
kubectl apply -f ./springboot-demo-app/k8s
```

Check pods:

```bash
kubectl get pods
```

Access the application:

```bash
kubectl port-forward svc/springboot-demo-app 8080:8080
```

Open:

```
http://localhost:8080
```

---

# Deploy Locally with Kubernetes (Minikube)

Start the cluster:

```bash
minikube start
```

Load the image:

```bash
minikube image load springboot-demo-app:local
```

Deploy the manifests:

```bash
kubectl apply -f ./springboot-demo-app/k8s
```

Port forward:

```bash
kubectl port-forward svc/springboot-demo-app 8080:8080
```

---

# GitOps Deployment with Argo CD

Argo CD continuously monitors the Git repository and ensures the Kubernetes cluster matches the desired state defined in Git.

Workflow:

```
Git Push
   │
   ▼
Argo CD detects change
   │
   ▼
Kubernetes Deployment updated
   │
   ▼
New Pods created
```

---

# GitOps Demo

1. Edit the Kubernetes deployment manifest:

```
springboot-demo-app/k8s/deployment.yaml
```

Change:

```
replicas: 3
```

to:

```
replicas: 5
```

2. Commit and push:

```bash
git add .
git commit -m "scale deployment"
git push
```

3. Argo CD automatically detects the change and syncs the cluster.

Verify:

```bash
kubectl get pods
```

You should see additional pods created.

---

# Automation Scripts

Helper scripts are available in the `scripts` folder.

Examples:

Deploy to a Kind cluster:

```bash
./scripts/deploy-kind.ps1
```

Check cluster status:

```bash
./scripts/check-status.ps1
```

Reset the cluster:

```bash
./scripts/reset-cluster.ps1
```

---

# Project Documentation

Additional documentation is available in the `docs` folder.

```
docs/
│
├ architecture.md   → system architecture
├ quickstart.md     → quickstart setup guide
├ ops-runbook.md    → troubleshooting and operations
└ smoke-test.md     → application verification tests
```

---

# Health Probes

Kubernetes probes are configured for:

```
/actuator/health/liveness
/actuator/health/readiness
```

These ensure Kubernetes can detect unhealthy containers and restart them if necessary.

---

# Notes

* The application runs on **port 8080**
* Docker image tag used for local deployments:

```
springboot-demo-app:local
```

* Designed for **local Kubernetes testing and DevOps exercises**
* No external dependencies (database, message broker, etc.)

---

# Summary

This project demonstrates a complete **local DevOps workflow** including:

* Containerization with Docker
* Kubernetes deployment
* Horizontal pod scaling
* GitOps deployment using Argo CD
* Automated synchronization between Git and the cluster

It serves as a **simple, stable application for testing deployment pipelines and GitOps workflows**.
