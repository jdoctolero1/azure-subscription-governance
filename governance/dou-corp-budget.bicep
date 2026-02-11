targetScope = 'subscription'

param budgetName string
param budgetAmount int
param startDate string
param endDate string
param notifications object

module douCorpBudget '../modules/budgets/subscription.bicep' = {
  params: {
    budgetName: budgetName
    budgetAmount: budgetAmount
    startDate: startDate
    endDate: endDate
    notifications: notifications
  }
}

output budgetId string = douCorpBudget.outputs.budgetId
