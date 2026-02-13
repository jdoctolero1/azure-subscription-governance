param (
  [string]$Region = "centralus",
  [string]$Environment = "lab"
)

Write-Host "[INFO] $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff zzz') What If Subscription Governance is applied."
az deployment sub what-if `
  --name "deploy-corp-governance-$(Get-Date -Format 'yyyyMMddHHmmss')" `
  --location $Region `
  --template-file ./orchestration/main.bicep `
  --parameters ./environments/$Environment/$Environment.bicepparam