$ErrorActionPreference = "Stop"

$namespace = "springboot-demo"
$appName = "springboot-demo-app"
$localPort = 8080

Write-Host "Checking Argo CD application..."
kubectl get application $appName -n argocd

Write-Host "Checking deployment..."
kubectl get deployment $appName -n $namespace

Write-Host "Checking pod..."
kubectl get pods -n $namespace -l app.kubernetes.io/name=$appName

Write-Host "Checking service..."
kubectl get service $appName -n $namespace

Write-Host "Starting port-forward..."
$portForward = Start-Process powershell -ArgumentList "-NoProfile", "-Command", "kubectl port-forward -n $namespace svc/$appName ${localPort}:8080" -PassThru -WindowStyle Hidden

try {
    Start-Sleep -Seconds 5

    Write-Host "Checking actuator health..."
    $health = Invoke-RestMethod -Uri "http://localhost:$localPort/actuator/health"
    $health | ConvertTo-Json -Depth 5

    Write-Host "Checking hello endpoint..."
    $hello = Invoke-RestMethod -Uri "http://localhost:$localPort/api/hello"
    $hello | ConvertTo-Json -Depth 5

    Write-Host "Smoke test passed."
}
finally {
    if ($portForward -and !$portForward.HasExited) {
        Stop-Process -Id $portForward.Id -Force
    }
}
