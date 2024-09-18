# ${{ values.name }}

Welcome to the create azure subscription template. To be used with Backstage.io

# Microsoft Azure Virtual Machine Module

## Purpose
This module provides support for the creation of a Subscription in MS Azure.

## Description
The Azure Subscription module is for use creating a single Subscription 

## Usage Instructions
Built for use alongside other modules or in isolation

```commandline
locals {
    common_tags = {
        ManagedBy = "terraform"
       }
}

module "create_subscription" {
  source  = "gitlab-master.datahubnow.com/terraform/create-subscription/azure"
  version = "0.0.2"

  billing_account_name    = "12345"
  enrollment_account_name = "67890"
  subscription_name       = "My Workload"
  subscription_tags       = {"Department"="Platform Engineering","CostCenter"="012345","Project"="Uvance","CreatedBy"="garrard.kitchen@fujitsu.com"}'
  lz_type                 = "Application"
  lz_platform_type        = ""
}

```

## Preconditions and Assumptions

None

## Requirements

No Requirements

## Providers

| Name    | Version |
|---------|---------|
| azurerm | 3.107   |
| terraform clinet | 1.9.5 |

## Resources

| Name                                              | Type     |
|---------------------------------------------------|----------|
| azurerm_subscription                              | resource |


## Inputs

| Name                        | Description | Type         | Default | Required |
|-----------------------------|-------------|--------------|---------|----------|
| billing_account_name        | n/a         | string       | n/a     | yes      |
| enrollment_account_name     | n/a         | string       | n/a     | yes      |
| subscription_tags           | n/a         | map(string)  | n/a     | yes      |
| subscription_name           | n/a         | string       | n/a     | yes      |
| lz_type                     | n/a         | string       | n/a     | yes      |
| lz_platform_type            | n/a         | string       | n/a     | no       |

## Outputs

| Name               | Description |
|--------------------|-------------|
| subscription_id    | The ID of the Subscription |


## Example tfvars file

```commandline
  source                  = "git::gitlab-master.datahubnow.com/terraform/create-subscription/azure"
  billing_account_name    = "12345"
  enrollment_account_name = "67890"
  subscription_name       = "Workload MCK Cluster"
  lz_type                 = "Application"
  subscription_tags       = {"Department"="Platform Engineering","CostCenter"="012345","Project"="Uvance","CreatedBy"="garrard.kitchen@fujitsu.com"}
```
