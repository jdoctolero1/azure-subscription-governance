targetScope = 'subscription' // Definitions are usually subscription-level

param policyName string
param policyDisplayName string

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
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
      allowedValues: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed Values'
          description: 'The list of allowed values for the environment tag.'
        }
        defaultValue: [
          'dev'
          'lab'
          'stg'
          'prd'
        ]
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
            notIn: '[parameters(\'allowedValues\')]'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

output policyDefinitionId string = policyDefinition.id
