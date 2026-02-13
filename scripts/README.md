# Scripts
This directory contains the PowerShell scripts required to deploy governance artifacts at the subscription level, including a `what-if.ps1` script to preview changes prior to deployment.

## Description
- Deploys Azure governance (custom policy definitions, initiatives, assignments, and budget).
- Intended to apply a consistent governance baseline to a subscription.

## Prerequisites
- Windows PowerShell 7+ or Windows PowerShell 5.1.
- AZ CLI installed
- Signed in to Azure az login with an account that has appropriate privileges (Owner/Policy Contributor/Management Group Contributor).

## Usage
From a powershell window run the command from the top-directory of the repo.

### Execute the `what-if.ps1` script to simulate the deployment and review the proposed changes before applying them.
```
./scripts/what-if.ps1
```

### Deploying the governance artifacts
```
./scripts/deploy-governance.ps1
```

## Optional Parameters

### `Region`
- **Default:** `centralus`
- **Required:** Yes

Although governance resources are deployed at the **subscription level**, a region must still be specified for the deployment operation.

---

### `Environment`
- **Default:** `lab`
- **Required:** Yes

Specifies which environment configuration to use.

This value must correspond to a valid environment folder and .bicepparam file under: ./environments

## Notes & troubleshooting
- Ensure the account has permission to create budgets, policy definitions and assignments at the chosen scope.
- If definitions already exist, the script usually updates them; review with the what-if.ps1 script