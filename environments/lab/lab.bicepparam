using '../../orchestration/main.bicep'

param allowedEnvironmentTagValues = [
  'lab'
  'dev'
  'stg'
  'prd'
]

param allowedVmSizes = [
  'Standard_B1s'
  'Standard_B2s'
  'Standard_D2s_v3'
  'Standard_D2s_v4'
]

param restrictedVmSizeEnvironments = [
  'lab'
  'dev'
]
