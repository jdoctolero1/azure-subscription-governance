# Environments

This folder contains environment-specific Bicep parameter files used to deploy the governance initiative and its assignments.

## Purpose
- Keep per-environment policy parameter values (allowed VM sizes, allowed locations, tag names, etc.) separate from templates.
- Provide a single source-of-truth when validating or deploying the orchestration template.

## File format
- Files are Bicep parameter files. Each file should assign an object to `param policyParameters` with the keys expected by the initiative and policy modules.
- Example keys used in this repo:
  - `allowedVmSizes` — list of allowed VM SKUs (array)
  - `allowedVmSizeEnvironments` — environments that get VM size restrictions (array)
  - `allowedEnvironmentTagValues` — allowed values for the environment tag (array)
  - `allowedLocations` — list of allowed Azure locations (array)

## Example (lab.bicepparam)
```bicep-params
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

param allowedEnvironmentTagValues = [
  'lab'
  'dev'
  'stg'
  'prd'
]

param listOfAllowedLocations = [
  'centralus'
  'eastus'
]
```

## Best practices
- Keep sensitive values out of these files. Use Key Vault references if necessary.
- Maintain one file per environment (lab, dev, prod) and keep naming consistent: `<env>.bicepparam`.
- When changing initiative parameter types, prefer creating a new parameter name or delete/recreate the initiative to avoid Azure type-update restrictions.
