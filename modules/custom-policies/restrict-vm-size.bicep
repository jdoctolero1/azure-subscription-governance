targetScope = 'subscription' 

@description('The short name for the policy resource ID.')
@minLength(5)
param policyName string

@description('The policy display name that shows up in the Azure Portal.')
param policyDisplayName string

@description('The policy display name that shows up in the Azure Portal.')
param allowedVmSizes array = [
  'Standard_B1s'
  'Standard_B2s'
  'Standard_D2s_v3'
  'Standard_D2s_v4'
]

@description('The environments that will be restricted to the allowed VM sizes.')
param environments array =  [
  'dev' 
  'lab'
]

resource restrictVmSizePolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: 'Limits VM sizes to lower cost sizes if the resource is tagged as lab or dev.'
    policyType: 'Custom'
    mode: 'All'
    metadata: {
      category: 'Compute'
      version: '1.0.0'
    }
    parameters: {
      allowedVmSizes: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed Dev VM Sizes'
          description: 'The list of SKUs allowed for lab or dev environments.'
        }
        defaultValue: allowedVmSizes
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
            in: environments
          }
          {
            not: {
              field: 'Microsoft.Compute/virtualMachines/sku.name'
              in: '[parameters(\'allowedVmSizes\')]'
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

output policyDefinitionId string = restrictVmSizePolicyDefinition.id
