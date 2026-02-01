targetScope = 'subscription'

@description('The short name for the policy resource ID.')
@minLength(5)
param policyName string

@description('The policy display name that shows up in the Azure Portal.')
param policyDisplayName string

@description('The locations that resource are allowed to be deployed to.')
param allowedLocations array

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    policyType: 'Custom'
    mode: 'All' // 'All' evaluates both Resource Groups and Resources
    displayName: policyDisplayName
    description: 'Enforces that all resources are deployed in the primary or DR regions.'
    metadata: {
      category: 'Governance'
      version: '1.0.0'
    }
    parameters: {
      listOfAllowedLocations: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed Locations'
          description: 'The list of regions where resources can be deployed.'
        }
        defaultValue: allowedLocations
      }
    }
    policyRule: {
      if: {
        field: 'location'
        notIn: '[parameters(\'listOfAllowedLocations\')]'
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

output policyDefinitionId string = policyDefinition.id
