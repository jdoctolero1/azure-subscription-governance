# Azure Governance - Why is this necessary

## The Company
DevOps Unlimited (DOU) is a Cloud and Platform Engineering consulting company that provides engineering transformation services to it's clients.

##  The Problem
The company recently discovered they were using expensive VM sizes in their non-production environments. They also discovered resources were being created in higher cost regions such as Brazil, which was not a region typically utiilized by the company.

In addition to this, there was no alerting around budget limits. Management was not being alerted when budget costs were approaching a specified threshold.

## The Solution
Using bicep templates the engineering team developed a governance methodology to standardize their subscriptions.

A baseline Initiative has been established and assigned to manage governance of subscriptions.

Policies Applied
- Require the Tag named 'environment' on all resources.
- All resources will inherit the 'environment' tag from it's resource group.
- Restrict the values the 'environment' tag may have.
- For non-production environements restrict the VM Sizes that are allowed based on the 'environment' tag.
- Limit the regions in which resources can be provisioned.

