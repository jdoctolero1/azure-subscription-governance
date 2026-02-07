targetScope = 'subscription'

param policyDefinitionId string
param policyAssignmentName string
param policyParameters object
param policyMetadata object = {assignedBy: 'Bicep Automation'}

module policyAssignment 'br/public:avm/res/authorization/policy-assignment/sub-scope:0.1.0' = {
  params: {
    name: policyAssignmentName
    policyDefinitionId: policyDefinitionId
    parameters: policyParameters
    metadata: policyMetadata
  }
}

output policyAssignmentId string = policyAssignment.outputs.resourceId
