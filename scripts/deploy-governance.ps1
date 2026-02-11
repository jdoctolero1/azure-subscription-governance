param (
  [string]$Region = "centralus",
  [string]$Environment = "lab"
)

Write-Host "[INFO] Deploying Policies to Subscription"
az deployment sub create `
  --name "deploy-corp-governance-$(Get-Date -Format 'yyyyMMddHHmmss')" `
  --location $Region `
  --template-file ./orchestration/main.bicep `
  --parameters ./environments/$Environment/$Environment.bicepparam