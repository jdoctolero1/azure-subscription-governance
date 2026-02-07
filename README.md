# Azure Subscription Governance

This project contains bicep code to deploy custom policies, intitiatives and budgets to enforce compliance and control costs in an Azure subscription.

## Under Construction

**This project is under construction. Please be patient.**

## Use Case
Please see the [Case Study](./CASE-STUDY.md) for more information on the scenario this project covers.

## Custom Policy Definitions
Deploys custom policy definitions.

The custom policy definitions built by this project include:
- Restrict the values that the 'environment' tag can have
- Restrict the VM sizes that are allowed based on the 'environment' tag.

## Initiative
Creates a baseline inititaive to manage tags for governance and to restrict VM sizes and regions that resource can be deployed in.

The built-in policy scenarios targeted by this repo include:
- Enforcing a tag on resources
- Enforcing allowed locations
- Inheriting tags from the resource group

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.