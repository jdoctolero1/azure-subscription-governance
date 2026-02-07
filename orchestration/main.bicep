targetScope = 'subscription'

module corporateBaselineInitiative '../governance/dou-corp-baseline-initiative.bicep' = {
  name: 'deploy-environment-tag-initiative'
  // params: {
  //   allowedEnvironmentTagValues: [
  //     'dev'
  //     'lab'
  //     'stg'
  //     'prd'
  //   ]
  //   allowedLabVmSizes: [
  //     'Standard_B1s'
  //     'Standard_B2s'
  //     'Standard_D2s_v3'
  //     'Standard_D2s_v4'
  //   ]
  //   labEnvironments: ['dev', 'lab']
  // }
}

var corporateBaselineInitiativeId = corporateBaselineInitiative.outputs.initiativeId

//Assign the initiative to the current subscription
module corporateBaselineInitiativeAssignment '../modules/policy-assignments/subscription.bicep' = {
  name: 'deploy-corporate-baseline-initiative-assignment'
  params: {
    policyAssignmentName: 'DevOps Unlimited Corporate Baseline Assignment'
    policyDefinitionId: corporateBaselineInitiativeId
    // policyParameters: {}
    policyParameters: {
      tagName: { value : 'environment'}
      allowedVmSizes: {
        value: [
          'Standard_B1s'
          'Standard_B2s'
        ]
      }
      allowedVmSizeEnvironments : {
        value: [
          'lab'
          'dev'
        ]
      }
      allowedEnvironmentTagValues : {
        value: [
          'lab'
          'dev'
          'stg'
          'prd'
        ]
      }
    }
  }
}

output corporateBaselineInitiativeAssignmentId string = corporateBaselineInitiativeAssignment.outputs.policyAssignmentId
