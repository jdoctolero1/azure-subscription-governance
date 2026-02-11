targetScope = 'subscription'

param budgetName string = 'monthly-subscription-budget'
param budgetAmount int = 500
param startDate string = '2026-01-01'
param endDate string = '2030-12-31'

param notifications object 

resource budget 'Microsoft.Consumption/budgets@2023-05-01' = {
  name: budgetName
  properties: {
    category: 'Cost'
    amount: budgetAmount
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: startDate
      endDate: endDate
    }

    notifications: notifications
  }
}

output budgetId string = budget.id
