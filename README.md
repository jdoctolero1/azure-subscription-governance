# Azure Subscription Governance

This project contains bicep code to deploy custom policies, intitiatives and budgets to enforce compliance and control costs in an Azure subscription.

## Under Construction

**This project is under construction. Please be patient. 

## Use Case

## Custom Policy Definitions
Deploys custom policy definitions. As part of the subscription build I needed to limit VM sizes for non-production environments in order to save costs. I created a policy definitions that will limit VM sizes based on the environment tag on the resource group.

## Initiative
Creates a baseline inititaive to manage tags for governance and to restrict VM sizes and regions that resource can be deployed in.

The built-in policy scenarios targeted by this repo include:
- Enforcing a tag on resources
- Enforcing allowed locations
- Inheriting tags from the resource group

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.