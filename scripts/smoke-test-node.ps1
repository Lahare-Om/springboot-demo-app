$ErrorActionPreference = "Stop"

$namespace = "springboot-demo"
$appName = "node-demo-app"
$localPort = 8002

Write-Host "Checking Node app deployment..."
kubectl get deployment $appName -n $namespace

Write-Host "Checking Node app pod..."
kubectl get pods -n $namespace -l app.kubernetes.io/name=$appName

Write-Host "Checking Node app service..."
kubectl get service $appName -n $namespace

Write-Host "Starting port-forward for Node app..."
$portForward = Start-Process powershell -ArgumentList "-NoProfile", "-Command", "kubectl port-forward -n $namespace svc/$appName ${localPort}:3000" -PassThru -WindowStyle Hidden

try {
    Start-Sleep -Seconds 5

    Write-Host "Checking Node app health..."
    $health = Invoke-RestMethod -Uri "http://localhost:$localPort/health"
    $health | ConvertTo-Json -Depth 5

    Write-Host "Checking Node app info..."
    $info = Invoke-RestMethod -Uri "http://localhost:$localPort/api/info"
    $info | ConvertTo-Json -Depth 5

    Write-Host "Testing Node app echo endpoint..."
    $echo = Invoke-RestMethod -Uri "http://localhost:$localPort/api/echo/hello%20node"
    $echo | ConvertTo-Json -Depth 5

    Write-Host "Node app smoke test passed."
}
finally {
    if ($portForward -and !$portForward.HasExited) {
        Stop-Process -Id $portForward.Id -Force
    }
}
