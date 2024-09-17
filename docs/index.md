# ${{ values.component_id }}

${{ values.description }}

name: _${{ values.name }}_

## Getting started

Start writing your documentation by adding more markdown (.md) files to this
folder (/docs) or replace the content in this file.

## GitHub Secrets

| Name | Purpose |
|:--|:--|
|  TF_API_TOKEN | Token to allow GH to perform requires actions. e.g. Create workspaces, to run plan and apply and to interact with the TFC/E HTTP API |

## GitHub Variables

| Name | Value | Purpose |
|:--|:--|:--|
| ORG_NAME | $(( values.orgName }} | Used when creating the Workspace in TFC/E |
| PROJECT_ID | $(( values.projectId }} | Used when assigned the Workspace to a TFC/E Project |
| WORKSPACE_NAME | $(( values.workspaceName }} | Used to name your Workspace in TFC/E | 
