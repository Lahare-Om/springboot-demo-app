$ErrorActionPreference = "Stop"

$namespace = "springboot-demo"
$appName = "python-demo-app"
$localPort = 8001

Write-Host "Checking Python app deployment..."
kubectl get deployment $appName -n $namespace

Write-Host "Checking Python app pod..."
kubectl get pods -n $namespace -l app.kubernetes.io/name=$appName

Write-Host "Checking Python app service..."
kubectl get service $appName -n $namespace

Write-Host "Starting port-forward for Python app..."
$portForward = Start-Process powershell -ArgumentList "-NoProfile", "-Command", "kubectl port-forward -n $namespace svc/$appName ${localPort}:8000" -PassThru -WindowStyle Hidden

try {
    Start-Sleep -Seconds 5

    Write-Host "Checking Python app health..."
    $health = Invoke-RestMethod -Uri "http://localhost:$localPort/health"
    $health | ConvertTo-Json -Depth 5

    Write-Host "Checking Python app info..."
    $info = Invoke-RestMethod -Uri "http://localhost:$localPort/api/info"
    $info | ConvertTo-Json -Depth 5

    Write-Host "Testing Python app echo endpoint..."
    $echo = Invoke-RestMethod -Uri "http://localhost:$localPort/api/echo/hello%20world"
    $echo | ConvertTo-Json -Depth 5

    Write-Host "Python app smoke test passed."
}
finally {
    if ($portForward -and !$portForward.HasExited) {
        Stop-Process -Id $portForward.Id -Force
    }
}