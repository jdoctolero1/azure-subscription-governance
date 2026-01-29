targetScope = 'subscription'

param policyDefinitions array

// param policyDefinitions array = [
//   {
//     policyName: 'enforce-vm-sizes-by-environment-tag'
//     displayName: 'Restrict VM Sizes based on Environment Tag'
//     description: 'Denies expensive VM sizes if the resource group is tagged as Dev.'
//     policyType: 'Custom'
//     mode: 'All'
//     metadata: {
//       category: 'Compute'
//       version: '1.0.0'
//     }
//     parameters: {
//       allowedDevSizes: {
//         type: 'Array'
//         metadata: {
//           displayName: 'Allowed Dev VM Sizes'
//           description: 'The list of SKUs allowed for Dev environments.'
//         }
//         defaultValue: [
//           'Standard_B1s'
//           'Standard_B2s'
//         ]
//       }
//     }
//     policyRule: {
//       if: {
//         allOf: [
//           {
//             field: 'type'
//             equals: 'Microsoft.Compute/virtualMachines'
//           }
//           {
//             field: 'tags.Environment'
//             equals: 'dev'
//           }
//           {
//             not: {
//               field: 'Microsoft.Compute/virtualMachines/sku.name'
//               in: '[parameters(\'allowedDevSizes\')]'
//             }
//           }
//         ]
//       }
//       then: {
//         effect: 'deny'
//       }
//     } 
//   }
// ]

module policyDefinition '../modules/policy-definitions/main.bicep'  = [for pd in policyDefinitions: {
  name: pd.policyName
  params: {
    policyName: pd.policyName
    policyType: pd.policyType
    policyDisplayName: pd.displayName
    policyDescription: pd.description
    policyCategory: pd.metadata.category
    policyVersion: pd.metadata.version
    policyParameters: pd.parameters
    policyRule: pd.policyRule
  }
}]

// resource vmSizeByTagPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
//   name: 'deny-vm-sizes-by-environment-tag'
//   properties: {
//     displayName: 'Restrict VM Sizes based on Environment Tag'
//     description: 'Denies expensive VM sizes if the resource group is tagged as Dev.'
//     policyType: 'Custom'
//     mode: 'All'
//     metadata: {
//       category: 'Compute'
//       version: '1.0.0'
//     }
//     parameters: {
//       allowedDevSizes: {
//         type: 'Array'
//         metadata: {
//           displayName: 'Allowed Dev VM Sizes'
//           description: 'The list of SKUs allowed for Dev environments.'
//         }
//         defaultValue: [
//           'Standard_B1s'
//           'Standard_B2s'
//         ]
//       }
//     }
//     policyRule: {
//       if: {
//         allOf: [
//           {
//             field: 'type'
//             equals: 'Microsoft.Compute/virtualMachines'
//           }
//           {
//             field: 'tags.Environment' // Checks the tag on the resource
//             equals: 'dev'
//           }
//           {
//             not: {
//               field: 'Microsoft.Compute/virtualMachines/sku.name'
//               in: '[parameters(\'allowedDevSizes\')]'
//             }
//           }
//         ]
//       }
//       then: {
//         effect: 'deny'
//       }
//     }
//   }
// }
