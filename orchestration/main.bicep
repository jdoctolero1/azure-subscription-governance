targetScope = 'subscription'

var policyDefinitionResourceRoot = 'Microsoft.Authorization/policyDefinitions'

param builtinPolicyAssignments array

module policyAssignmentModule '../modules/policy-assignments/subscription.bicep' = [for pa in builtinPolicyAssignments: {
  name: 'deploy-${pa.assignmentName}'
  params: {
    policyDefinitionId: tenantResourceId(policyDefinitionResourceRoot, pa.policyId)
    policyAssignmentName: pa.assignmentName
    policyParameters: pa.parameters
  }
}]
