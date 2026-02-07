targetScope = 'subscription'

var policyDefinitionResourceRoot = 'Microsoft.Authorization/policyDefinitions'
var initiativeDeploymentName = 'deploy-tagging-governance-initiative'
var initiativeName = 'dou-corp-baseline-initiative'
var initiativeDisplayName = '[Custom] DevOps Unlimited Corporate Baseline'
var initiativeDescription ='Initiative sets the standard governance for DevOps Unlimited.'
var initiativePolicyType = 'Custom'
var requiredTagName = 'environment'
var initiativeVersion = '1.0.0'
var initiativeCategory = 'Governance'

module restrictEnvironmentPolicy '../modules/custom-policies/restrict-environment-values.bicep' = {
  name: 'deploy-restrict-environment-policy'
  params: {
    policyName: 'deploy-restrict-environment-tag-values-policy'
    policyDisplayName: 'Restrict Environment Tag Values'
  }
}

module vmSizePolicy '../modules/custom-policies/restrict-vm-size.bicep' = {
  name: 'deploy-vm-size-policy'
  params: {
    policyName: 'deploy-vm-size-policy'
    policyDisplayName: 'Restrict VM Sizes by Environment'
  }
  dependsOn: [
    restrictEnvironmentPolicy
  ]
}

var policyDefinitions = [
  // Require 'environment' tag on resources Policy
  {
    policyDefinitionId: tenantResourceId(policyDefinitionResourceRoot, '871b6d14-10aa-478d-b590-94f262ecfa99')
    parameters: {
      tagName: {
        value: '[parameters(\'tagName\')]'
      }
    }
  }
  //Inherit environment tag from resource group
  {
    policyDefinitionId: tenantResourceId(policyDefinitionResourceRoot, 'cd3aa116-8754-49c9-a813-ad46512ece54')
    parameters: {
      tagName: {
        value: '[parameters(\'tagName\')]'
      }
    }
  }
  //Restrict Environment Tag Values
  {
    policyDefinitionId: restrictEnvironmentPolicy.outputs.policyDefinitionId
    parameters: {
      allowedEnvironmentTagValues: {
        value: '[parameters(\'allowedEnvironmentTagValues\')]'
      }
    }
  }
  // //Restrict VM Sizes based on Environment Tag
  {
    policyDefinitionId: vmSizePolicy.outputs.policyDefinitionId 
      parameters: {
       allowedVmSizes: {
        value: '[parameters(\'allowedVmSizes\')]'
       } 
       restrictedVmSizeEnvironments: {
        value: '[parameters(\'restrictedVmSizeEnvironments\')]'
       }       
      }
  }
  // Allowed Locations
  {
    policyDefinitionId: tenantResourceId(policyDefinitionResourceRoot, 'e56962a6-4747-49cd-b67b-bf8b01975c4c')
    parameters: {
      listOfAllowedLocations: {
        value: '[parameters(\'listOfAllowedLocations\')]'
      }
    }
  }
]

module initiativeModule '../modules/initiatives/main.bicep' = {
  name: initiativeDeploymentName
  params: {
    initiativeName: initiativeName
    initiativeDisplayName: initiativeDisplayName
    initiativeDescription: initiativeDescription
    initiativePolicyType: initiativePolicyType
    initiativeMetadata: {
      category: initiativeCategory
      version: initiativeVersion
    }
    initiativeParameters: {
      tagName : {
        type: 'String'
        metadata: {
          displayName: 'Tag name to enforce'
        }
        defaultValue: requiredTagName
      }
      allowedEnvironmentTagValues: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed Environment Tag Values'
          description: 'Allowed values for the environment tag.'
        }
        defaultValue: ['lab']
      }
      allowedVmSizes : {
        type: 'Array'
        metadata: {
          displayName: 'Allowed VM sizes'
        }
        defaultValue: ['Standard_B1s']
      }
      restrictedVmSizeEnvironments : {
        type: 'Array'
        metadata: {
          displayName: 'Allowed VM sizes by environment'
        }
        defaultValue: ['lab']
      }
      listOfAllowedLocations : {
        type: 'Array'
        metadata: {
          displayName: 'Allowed Locations that Resource can be deployed'
        }
        defaultValue: ['centralus']
      }
    }
    initiativePolicyDefinitions : policyDefinitions
  }
}

output initiativeId string = initiativeModule.outputs.initiativeId
