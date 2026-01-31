targetScope = 'subscription'

@description('The display name for the governance initiative. Default: Our Company Governance Baseline')
param initiativeDisplayName string = 'Our Company Governance Baseline'

@description('The description of the governance initiative')
param initiativeDescription string = 'A collection of policies to enforce corporate naming and regional standards.'

@description('The policy type. Default: Custom')
param initiativePolicyType string = 'Custom'

@description('The metadata for the initiative. Includes category and version.')
param initiativeMetadata object

@description('The parameters for the initiative. These are sent downstream to policies within the initiative.')
param initiativeParameters object

@description('The policies to be added to the initiative.')
param initiativePolicyDefinitions array


resource governanceInitiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: 'corp-governance-baseline'
  properties: {
    displayName: initiativeDisplayName
    description: initiativeDescription
    policyType: initiativePolicyType
    metadata: initiativeMetadata
    parameters: initiativeParameters
    policyDefinitions: initiativePolicyDefinitions
  }
}

output initiativeId string = governanceInitiative.id
