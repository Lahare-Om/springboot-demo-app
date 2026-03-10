Write-Host "Creating Kind cluster..."

kind create cluster

Write-Host "Loading Docker image..."

kind load docker-image springboot-demo-app:local

Write-Host "Deploying Kubernetes manifests..."

kubectl apply -f k8s/

Write-Host "Deployment complete!"
kubectl get pods