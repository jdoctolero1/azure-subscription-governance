targetScope = 'subscription'

param policyDefinitions array

module policyDefinition '../modules/policy-definitions/main.bicep'  = [for pd in policyDefinitions: {
  name: pd.policyName
  params: {
    policyName: pd.policyName
    policyType: pd.policyType
    policyDisplayName: pd.displayName
    policyDescription: pd.description
    policyCategory: pd.metadata.category
    policyVersion: pd.metadata.version
    policyParameters: pd.parameters
    policyRule: pd.policyRule
  }
}]
