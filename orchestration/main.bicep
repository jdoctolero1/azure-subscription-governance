targetScope = 'subscription'

module corporateBaselineInitiative '../governance/dou-corp-baseline-initiative.bicep' = {
  name: 'deploy-environment-tag-initiative'
}

var corporateBaselineInitiativeId = corporateBaselineInitiative.outputs.initiativeId

// Assign the initiative to the current subscription
module corporateBaselineInitiativeAssignment '../modules/policy-assignments/subscription.bicep' = {
  name: 'deploy-corporate-baseline-initiative-assignment'
  params: {
    policyAssignmentName: 'DevOps Unlimited Corporate Baseline Assignment'
    policyDefinitionId: corporateBaselineInitiativeId
    policyParameters: {}
  }
}

output corporateBaselineInitiativeAssignmentId string = corporateBaselineInitiativeAssignment.outputs.policyAssignmentId
