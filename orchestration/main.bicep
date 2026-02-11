targetScope = 'subscription'

@description('The allowed VM sizes for the non-production environments')
param allowedVmSizes array
@description('The non-production environments')
param restrictedVmSizeEnvironments array
@description('The allowed values for the environment tag. ex: lab, dev, stg, prd')
param allowedEnvironmentTagValues array
@description('The regions that resource are allowed to be created in.')
param listOfAllowedLocations array

@description('The name of the budget.')
param budgetName string
@description('The budget amount to be used as a baseline for forecasted and actual limits.')
param budgetAmount int
@description('Start date of the budget. IMPORTANT: Month must be greater than or equal to the current month if start date is this year.')
param startDate string
@description('Date the budget expires')
param endDate string
@description('The notification rules for the budget')
param notifications object

module corporateBaselineInitiative '../governance/dou-corp-baseline-initiative.bicep' = {
  name: 'deploy-corp-baseline-initiative'
}

//Assign the initiative to the current subscription
module corporateBaselineInitiativeAssignment '../governance/dou-corp-baseline-assignment.bicep' = {
  name: 'deploy-dou-corp-baseline-initiative-assignment'
  params: {
    initiativeId: corporateBaselineInitiative.outputs.initiativeId
    allowedVmSizes: allowedVmSizes
    restrictedVmSizeEnvironments: restrictedVmSizeEnvironments
    allowedEnvironmentTagValues: allowedEnvironmentTagValues
    listOfAllowedLocations: listOfAllowedLocations
  }
}

//Build the budget
module corporateBudget '../governance/dou-corp-budget.bicep' = {
  name: 'deploy-dou-corp-budget'
  params: {
     budgetName: budgetName
     budgetAmount: budgetAmount
     startDate: startDate
     endDate: endDate
     notifications: notifications
  }
  dependsOn: [
    corporateBaselineInitiative
    corporateBaselineInitiativeAssignment
  ]
}

output corporateBaselineInitiativeId string = corporateBaselineInitiative.outputs.initiativeId
output corporateBaselineInitiativeAssignmentId string = corporateBaselineInitiativeAssignment.outputs.policyAssignmentId
output corporateBudgetId string = corporateBudget.outputs.budgetId
