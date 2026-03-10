Write-Host "Deleting cluster..."

kind delete cluster

Write-Host "Creating fresh cluster..."

kind create cluster

Write-Host "Cluster reset complete!"