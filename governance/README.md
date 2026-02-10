# Governance

## Overview
This directory contains the Bicep artifacts that define the DevOps Unlimited (DOU) corporate baseline initiative and its subscription assignment.

## Contents
- dou-corp-baseline-initiative.bicep — creates the initiative (policy set) definition.
- dou-corp-baseline-assignment.bicep — subscription-level assignment of the initiative.

## Deployment
- The ./orchestration/main.bicep file depends on these modules to create and assign the initiative.