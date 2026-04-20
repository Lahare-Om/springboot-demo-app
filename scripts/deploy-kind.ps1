Write-Host "Creating Kind cluster..."

kind create cluster

Write-Host "Building Spring Boot image..."
docker build -t springboot-demo-app:local .

Write-Host "Building Python app image..."
docker build -t python-demo-app:0.1.0 .\python-app

Write-Host "Building Node app image..."
docker build -t node-demo-app:0.1.0 .\node-api

Write-Host "Building Go app image..."
docker build -t go-api:0.1.0 .\go-api

Write-Host "Building Rust app image..."
docker build -t rust-api:0.1.0 .\rust-api

Write-Host "Building .NET app image..."
docker build -t dotnet-api:0.1.0 .\dotnet-api

Write-Host "Building PHP app image..."
docker build -t php-app:0.1.0 .\php-app

Write-Host "Building Ruby app image..."
docker build -t ruby-app:0.1.0 .\ruby-app

Write-Host "Building Kotlin app image..."
docker build -t kotlin-app:0.1.0 .\kotlin-app

Write-Host "Building Elixir app image..."
docker build -t elixir-app:0.1.0 .\elixir-app

Write-Host "Loading Docker images..."

kind load docker-image springboot-demo-app:local
kind load docker-image python-demo-app:0.1.0
kind load docker-image node-demo-app:0.1.0
kind load docker-image go-api:0.1.0
kind load docker-image rust-api:0.1.0
kind load docker-image dotnet-api:0.1.0
kind load docker-image php-app:0.1.0
kind load docker-image ruby-app:0.1.0
kind load docker-image kotlin-app:0.1.0
kind load docker-image elixir-app:0.1.0

Write-Host "Deploying Kubernetes manifests..."

kubectl create namespace apps --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -k k8s/
kubectl apply -k k8s/python-app
kubectl apply -k k8s/node-api
kubectl apply -k k8s/go-api
kubectl apply -k k8s/rust-api
kubectl apply -k k8s/dotnet-api
kubectl apply -k k8s/php-app
kubectl apply -k k8s/ruby-app
kubectl apply -k k8s/kotlin-app
kubectl apply -k k8s/elixir-app

Write-Host "Deployment complete!"
kubectl get pods
