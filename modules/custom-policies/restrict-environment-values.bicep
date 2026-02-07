targetScope = 'subscription'

@description('The short name for the policy resource ID.')
@minLength(5)
param policyName string

@description('The policy display name that shows up in the Azure Portal.')
param policyDisplayName string

@description('The enviroment values that are allowed for the environment tag.')
param allowedEnvironmentTagValues array = [
  'lab'
  'dev'
  'stg'
  'prd' 
]

resource restrictEnvironmentTagValuesPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: 'Enforces that the Environment tag only contains approved values (case-insensitive).'
    policyType: 'Custom'
    mode: 'Indexed' // 'Indexed' targets resources that support tags and location
    metadata: {
      category: 'Governance'
      version: '1.0.0'
    }
    parameters: {
      allowedEnvironmentTagValues: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed Values'
          description: 'The list of allowed values for the environment tag.'
        }
        defaultValue: allowedEnvironmentTagValues
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'tags[environment]'
            exists: 'true'
          }
          {
            // This checks if the LOWERCASE version of the tag value is NOT in your list
            value: '[toLower(field(\'tags[environment]\'))]'
            notIn: '[parameters(\'allowedEnvironmentTagValues\')]'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

output policyDefinitionId string = restrictEnvironmentTagValuesPolicyDefinition.id
