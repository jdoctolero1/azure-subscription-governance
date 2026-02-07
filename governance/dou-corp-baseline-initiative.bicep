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
        value: requiredTagName
      }
    }
  }
  //Inherit environment tag from resource group
  {
    policyDefinitionId: tenantResourceId(policyDefinitionResourceRoot, 'cd3aa116-8754-49c9-a813-ad46512ece54')
    parameters: {
      tagName: {
        value: requiredTagName
      }
    }
  }
  //Restrict Environment Tag Values
  {
    policyDefinitionId: restrictEnvironmentPolicy.outputs.policyDefinitionId
    parameters: {}
  }
  //Restrict VM Sizes based on Environment Tag
  {
    policyDefinitionId: vmSizePolicy.outputs.policyDefinitionId 
    parameters: {}
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
    initiativeParameters: {}
    initiativePolicyDefinitions : policyDefinitions
  }
}

output initiativeId string = initiativeModule.outputs.initiativeId
