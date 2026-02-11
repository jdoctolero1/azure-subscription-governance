using '../../orchestration/main.bicep'

param allowedVmSizes = [
  'Standard_B1s'
  'Standard_B2s'
  'Standard_D2s_v3'
  'Standard_D2s_v4'
]

param restrictedVmSizeEnvironments = [
  'lab'
  'dev'
]

param allowedEnvironmentTagValues = [
  'lab'
  'dev'
  'stg'
  'prd'
]

param listOfAllowedLocations = [
  'centralus'
  'eastus'
]

var contactEmails = ['alerts@devops.com']

param budgetName = 'dou-corp-budget'
param budgetAmount = 20
param startDate = '2026-02-01'
param endDate = '2030-12-31'
param notifications = {
  forecastedNotification80: {
    enabled: true
    operator: 'GreaterThan'
    threshold: 80
    contactEmails: contactEmails
    thresholdType: 'Forecasted'
  }
  forecastedNotification90: {
    enabled: true
    operator: 'GreaterThan'
    threshold: 90
    contactEmails: contactEmails
    thresholdType: 'Forecasted'
  }
  actualNotification: {
    enabled: true
    operator: 'GreaterThan'
    threshold: 100
    contactEmails: contactEmails
    thresholdType: 'Actual'
  }
}
