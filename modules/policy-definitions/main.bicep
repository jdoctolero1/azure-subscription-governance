targetScope = 'subscription' // Definitions are usually subscription-level

@description('The short name of the policy (max 64 chars)')
@minLength(3)
@maxLength(64)
param policyName string

@description('The category for the Portal UI (e.g., Governance, Security, Networking)')
param policyType string

@description('The mode of the policy definition (e.g., All, Indexed, Microsoft.KeyVault.Data)')
param policyMode string = 'All'

@description('The display name of the policy in the Portal UI')
param policyDisplayName string

@description('The description of the policy')
param policyDescription string

@description('The category of the policy for metadata purposes')
param policyCategory string

@description('The version of the policy following SemVer (e.g., 1.0.0)')
param policyVersion string

@description('The user configurable parameters for the policy definition')
param policyParameters object

@description('The policy rule object defining the conditions and effects of the policy')
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
