# Modules

This folder contains reusable Bicep modules used by the governance orchestration templates.

## Available modules

- **custom-policies/** — individual custom policy modules (examples: `restrict-environment-values.bicep`, `restrict-vm-size.bicep`, `allowed-locations.bicep`). Use these to create reusable policy definitions.

- **initiatives/** — module to create a policy set (initiative). The module accepts parameters for `initiativeName`, `initiativeDisplayName`, `initiativeMetadata`, `initiativeParameters` and `initiativePolicyDefinitions` and outputs the created initiative id.

- **policy-assignments/** — modules to create policy assignments (subscription or scope-level). These accept `policyAssignmentName`, `policyDefinitionId` and `policyParameters`.

## Usage

Import modules from the root orchestration or governance templates. Example:

```bicep
module vmSizePolicy '../modules/custom-policies/restrict-vm-size.bicep' = {
	name: 'deploy-restrict-vm-size'
	params: {
		policyName: 'restrict-vm-size-policy'
		policyDisplayName: 'Restrict VM sizes'
	}
}
```

Keep module parameters stable (types and names) once deployed in production to avoid Azure update restrictions on policy set parameters.

## Contributing

- Add new modules under the appropriate subfolder and document the expected parameters and outputs.
- Keep module names and parameter names consistent to simplify wiring between templates.
