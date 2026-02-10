# Orchestration

This folder contains Bicep artifacts used to deploy orchestration of Azure governance initiatives.

## Purpose
The `main.bicep` in this folder is the entry template executed by the repository's deployment scripts. The deployment scripts call `main.bicep` to create the orchestration that provisions initiatives and their assignments across the subscription/management group scope.

## Files
- `main.bicep` — entry Bicep template for orchestration of initiatives.
- (Any environment-specific parameter files or templates used by your deployment scripts.)

## Notes
- Review deployment script in the repo root or `scripts/` folder to see how `main.bicep` is invoked and which parameters are required.