targetScope = 'subscription'

var policyDefinitionResourceRoot = 'Microsoft.Authorization/policyDefinitions'

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
    policyDisplayName: 'Restrict VM Sizes'
  }
  dependsOn: [
    restrictEnvironmentPolicy
  ]
}

var policyList = [
  // Require 'environment' tag on resources Policy
  {
    policyDefinitionId: tenantResourceId(policyDefinitionResourceRoot, '871b6d14-10aa-478d-b590-94f262ecfa99')
    parameters: {
      tagName: {
        value: 'environment'
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
  //name: 'deploy-tagging-governance-initiative'
  params: {
    initiativeName: 'deploy-dou-corp-baseline-initiative'
    initiativeDisplayName: '[Custom] DevOps Unlimited Corporate Baseline'
    initiativeDescription: 'Initiative sets the standard governance for DevOps Unlimited.'
    initiativePolicyType: 'Custom'
    initiativeMetadata: {
      category: 'Tags'
      version: '1.0.0'
    }
    initiativeParameters: {}
    initiativePolicyDefinitions : policyList
  }
}

output initiativeId string = initiativeModule.outputs.initiativeId
