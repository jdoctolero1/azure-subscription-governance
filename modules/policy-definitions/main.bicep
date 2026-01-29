targetScope = 'subscription' // Definitions are usually subscription-level

param policyName string
param policyType string
param policyMode string = 'All'
param policyDisplayName string
param policyDescription string
param policyCategory string
param policyVersion string
param policyParameters object
param policyRule object

resource customPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: policyType
    mode: policyMode
    displayName: policyDisplayName
    description: policyDescription
    metadata: {
      category: policyCategory
      version: policyVersion
    }
    parameters: policyParameters
    policyRule: policyRule
  }
}

output policyDefinitionId string = customPolicy.id
