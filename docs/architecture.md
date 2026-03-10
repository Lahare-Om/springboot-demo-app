# System Architecture

This project demonstrates a local GitOps deployment pipeline using Docker, Kubernetes, and Argo CD.

## High-Level Flow

Developer pushes code to GitHub → Argo CD detects changes → Kubernetes cluster updates automatically.

1. Developer
2. GitHub Repository
3. Argo CD (GitOps Controller)
4. Kubernetes Cluster (Kind)
5. Deployment
6. Pods
7. Service
8. Browser / API Client



## Application Components

The application consists of:

- **Spring Boot Backend**
- **React Frontend**
- **Docker Container**
- **Kubernetes Deployment**

1. React UI
2. Spring Boot API
3. Docker Container
4. Kubernetes Pod



## GitOps Workflow

Argo CD continuously monitors the Git repository for changes.

Workflow:

1. Developer updates Kubernetes manifests in Git
2. Changes are pushed to GitHub
3. Argo CD detects repository updates
4. Argo CD syncs the cluster state with Git
5. Kubernetes updates the running application

1. Git Push
2. GitHub Repository
3. Argo CD detects change
4. Kubernetes Deployment updated
5. New Pods created


## Local Development Environment

This project runs entirely on a developer laptop.

Components:

- Docker Desktop
- Kind (local Kubernetes cluster)
- kubectl
- Argo CD

1. Laptop
2. Docker
3. Kind Kubernetes Cluster
4. S4pring Boot Pods



## Deployment Process

The application deployment process:

1. Build the Java application
2. Package into a Docker image
3. Load the image into the Kind cluster
4. Deploy Kubernetes manifests
5. Argo CD manages deployments using GitOps



