Write-Host "[INFO] Deploying Policies to Subscription"
az deployment sub create `
  --location centralus `
  --template-file ./orchestration/main.bicep