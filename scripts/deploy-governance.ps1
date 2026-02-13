param (
  [string]$Region = "centralus",
  [string]$Environment = "lab"
)

Write-Host "[INFO] $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff zzz') Deploying Subscription Governance"
az deployment sub create `
  --name "deploy-corp-governance-$(Get-Date -Format 'yyyyMMddHHmmss')" `
  --location $Region `
  --template-file ./orchestration/main.bicep `
  --parameters ./environments/$Environment/$Environment.bicepparam