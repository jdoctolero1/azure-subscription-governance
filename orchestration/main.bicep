targetScope = 'subscription'

param allowedVmSizes array
param restrictedVmSizeEnvironments array
param allowedEnvironmentTagValues array

module corporateBaselineInitiative '../governance/dou-corp-baseline-initiative.bicep' = {
  name: 'deploy-environment-tag-initiative'
}

//Assign the initiative to the current subscription
module corporateBaselineInitiativeAssignment '../modules/policy-assignments/subscription.bicep' = {
  name: 'deploy-corporate-baseline-initiative-assignment'
  params: {
    policyAssignmentName: 'DevOps Unlimited Corporate Baseline Assignment'
    policyDefinitionId: corporateBaselineInitiative.outputs.initiativeId
    policyParameters: {
      tagName: { value : 'environment'}
      allowedVmSizes: {
        value: allowedVmSizes
      }
      restrictedVmSizeEnvironments : {
        value: restrictedVmSizeEnvironments
      }
      allowedEnvironmentTagValues : {
        value: allowedEnvironmentTagValues
      }
    }
  }
}

output corporateBaselineInitiativeAssignmentId string = corporateBaselineInitiativeAssignment.outputs.policyAssignmentId
