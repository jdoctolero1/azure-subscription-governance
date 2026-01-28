targetScope = 'subscription'

param policyDefinitionId string
param policyAssignmentName string
param policyParameters object

module policyAssignment 'br/public:avm/res/authorization/policy-assignment/sub-scope:0.1.0' = {
  params: {
    name: policyAssignmentName
    policyDefinitionId: policyDefinitionId
    parameters: policyParameters
    metadata: {
      assignedBy: 'Bicep'
    }
  }
}
