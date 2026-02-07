targetScope = 'subscription'

@description('The allowed VM sizes for the non-production environments')
param allowedVmSizes array
@description('The non-production environments')
param restrictedVmSizeEnvironments array
@description('The allowed values for the environment tag. ex: lab, dev, stg, prd')
param allowedEnvironmentTagValues array
@description('The regions that resource are allowed to be created in.')
param listOfAllowedLocations array

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
      tagName: { value: 'environment'}
      allowedVmSizes: {
        value: allowedVmSizes
      }
      restrictedVmSizeEnvironments: {
        value: restrictedVmSizeEnvironments
      }
      allowedEnvironmentTagValues: {
        value: allowedEnvironmentTagValues
      }
      listOfAllowedLocations: {
        value: listOfAllowedLocations
      }
    }
  }
}

output corporateBaselineInitiativeAssignmentId string = corporateBaselineInitiativeAssignment.outputs.policyAssignmentId
