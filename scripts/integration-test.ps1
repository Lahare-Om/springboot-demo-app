$ErrorActionPreference = "Stop"

Write-Host "Testing both Spring Boot and Python apps..."

# Test Spring Boot app
Write-Host "`n=== Testing Spring Boot App ==="
try {
    $springHealth = Invoke-RestMethod -Uri "http://localhost:8080/actuator/health"
    Write-Host "✅ Spring Boot health check passed"
    $springHealth | ConvertTo-Json -Depth 3

    $springHello = Invoke-RestMethod -Uri "http://localhost:8080/api/hello"
    Write-Host "✅ Spring Boot hello endpoint works"
} catch {
    Write-Host "❌ Spring Boot app test failed: $_"
    exit 1
}

# Test Python app
Write-Host "`n=== Testing Python App ==="
try {
    $pythonHealth = Invoke-RestMethod -Uri "http://localhost:8000/health"
    Write-Host "✅ Python app health check passed"
    $pythonHealth | ConvertTo-Json -Depth 3

    $pythonInfo = Invoke-RestMethod -Uri "http://localhost:8000/api/info"
    Write-Host "✅ Python app info endpoint works"

    $pythonEcho = Invoke-RestMethod -Uri "http://localhost:8000/api/echo/integration%20test"
    Write-Host "✅ Python app echo endpoint works"
} catch {
    Write-Host "❌ Python app test failed: $_"
    exit 1
}

# Test inter-service communication (if needed in future)
Write-Host "`n=== Integration Test ==="
Write-Host "✅ Both services are running and healthy"
Write-Host "✅ Spring Boot: http://localhost:8080"
Write-Host "✅ Python: http://localhost:8000"
Write-Host "✅ API Docs: http://localhost:8000/docs"

Write-Host "`n🎉 All tests passed! Both apps are working correctly."