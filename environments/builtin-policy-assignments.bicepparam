using '../orchestration/main.bicep'

param builtinPolicyAssignments = [
  {
    policyId: 'e56962a6-4747-49cd-b67b-bf8b01975c4c'
    assignmentName: 'assign-allowed-locations-policy'
    parameters: {
      listOfAllowedLocations: {
          value: [  
            'eastus'
            'centralus'
          ]
        }
      }
  }
  {
    policyId: '871b6d14-10aa-478d-b590-94f262ecfa99'
    assignmentName: 'assign-tag-environment-policy'
    parameters: {
      tagName: {
        value: 'environment'
      } 
    }    
  }
]
