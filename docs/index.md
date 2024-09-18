# ${{ values.component_id }}

${{ values.description }}

name: _${{ values.name }}_

## Getting started

Start writing your documentation by adding more markdown (.md) files to this
folder (/docs) or replace the content in this file.

## GitHub Secrets

| Name | System | Purpose |
|:--|:--|:--|
|  TF_API_TOKEN | TFC/E | Token to allow GH to perform requires actions. e.g. Create workspaces, to run plan and apply and to interact with the TFC/E HTTP API |
| ARM_CLIENT_SECRET | Azure | ${{ values.orgName }} | Used by TFC/E for SP secret for authn into Azure to create the resources |

## GitHub Variables

| Name | System | Value | Purpose |
|:--|:--|:--|:--|
| ORG_NAME | TFC/E | ${{ values.orgName }} | Used when creating the Workspace in TFC/E |
| PROJECT_ID | TFC/E | ${{ values.projectId }} | Used when assigned the Workspace to a TFC/E Project |
| WORKSPACE_NAME | TFC/E | ${{ values.workspaceName }} | Used to name your Workspace in TFC/E | 
| ARM_CLIENT_ID | Azure | ${{ values.armClientId }} | Used by TFC/E for SP ID for authn into Azure to create the resources |
| ARM_SUBSCRIPTION_ID | Azure | ${{ values.armSubscriptionId }} | Used by TFC/E to connect to which Azure subscription |
| ARM_TENANT_ID | Azure | ${{ values.armTenantId }} | Used by TFC/E to connect to which Azure Tenant | 


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
