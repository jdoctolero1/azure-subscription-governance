using '../orchestration/policy-definitions.bicep'

param policyDefinitions = [
  {
    policyName: 'enforce-vm-sizes-by-environment-tag'
    displayName: 'Restrict VM Sizes based on Environment Tag'
    description: 'Denies expensive VM sizes if the resource group is tagged as Dev.'
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
          description: 'The list of SKUs allowed for Dev environments.'
        }
        defaultValue: [
          'Standard_B1s'
          'Standard_B2s'
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
            field: 'tags.Environment'
            equals: 'dev'
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
]
