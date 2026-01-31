targetScope = 'subscription' // Definitions are usually subscription-level

param policyName string
param policyDisplayName string

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: 'Denies expensive VM sizes if the resource group is tagged as lab or dev.'
    policyType: 'Custom'
    mode: 'All'
    metadata: {
      category: 'Compute'
      version: '1.0.0'
    }
    parameters: {
      allowedSizes: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed Dev VM Sizes'
          description: 'The list of SKUs allowed for lab or dev environments.'
        }
        defaultValue: [
          'Standard_B1s'
          'Standard_B2s'
          'Standard_D2s_v3'
          'Standard_D2s_v4'
        ]
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Compute/virtualMachines'
          }
          {
            field: 'tags.environment'
            in: ['dev', 'lab']
          }
          {
            not: {
              field: 'Microsoft.Compute/virtualMachines/sku.name'
              in: '[parameters(\'allowedSizes\')]'
            }
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    } 
  }
}

output policyDefinitionId string = policyDefinition.id
