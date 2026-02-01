param (
  [string]$Region = "centralus"
)

Write-Host "[INFO] Deploying Policies to Subscription"
az deployment sub create `
  --location $Region `
  --template-file ./orchestration/main.bicep