#!/bin/bash

# Set up environment variables
TFE_TOKEN="${TFE_TOKEN}"
ORG_NAME="${ORG_NAME}"
WORKSPACE_NAME="${WORKSPACE_NAME}"
PROJECT_ID="${PROJECT_ID}"
ARM_CLIENT_ID="${ARM_CLIENT_ID}"
ARM_CLIENT_SECRET="${ARM_CLIENT_SECRET}"
ARM_SUBSCRIPTION_ID="${ARM_SUBSCRIPTION_ID}"
ARM_TENANT_ID="${ARM_TENANT_ID}"

# Define the API endpoints
BASE_URL="https://app.terraform.io/api/v2/organizations/${ORG_NAME}"
BASE_PROJECT_URL="https://app.terraform.io/api/v2"
WORKSPACES_URL="${BASE_URL}/workspaces"
HEADERS=(
  -H "Authorization: Bearer ${TFE_TOKEN}"
  -H "Content-Type: application/vnd.api+json"
)
# Check if the workspace exists
response=$(curl -s "${WORKSPACES_URL}" "${HEADERS[@]}")
# echo "$response"

workspace_exists=$(echo "$response" | jq -r --arg WORKSPACE_NAME "$WORKSPACE_NAME" '.data[] | select(.attributes.name == $WORKSPACE_NAME) | .id')

echo "$workspace_exists"

if [ -z "$workspace_exists" ]; then
  # Create the workspace
  payload=$(jq -n --arg WORKSPACE_NAME "$WORKSPACE_NAME" '{
    data: {
      attributes: {
        name: $WORKSPACE_NAME
      },
      type: "workspaces"
    }
  }')
  create_response=$(curl -s -X POST "${WORKSPACES_URL}" "${HEADERS[@]}" -d "$payload")
  if [ "$(echo "$create_response" | jq -r '.data.id')" ]; then
    echo "Workspace '${WORKSPACE_NAME}' created successfully."
    workspace_id=$(echo "$create_response" | jq -r '.data.id')
  else
    echo "Failed to create workspace: $(echo "$create_response" | jq -r '.errors[].detail')"
    exit 1
  fi
else
  echo "Workspace '${WORKSPACE_NAME}' already exists."
  workspace_id="$workspace_exists"
fi

echo "$workspace_id"


##########################
# Set workspace parameters
##########################

# Define the API endpoint
api_endpoint="https://app.terraform.io/api/v2/workspaces/${workspace_id}/vars"

set_workspace_variable() {
    local key="$1"
    local value="$2"
    local category="${3:-env}" # env, terraform
    local sensitive="${4:-false}" # true, false

    payload=$(jq -n --arg key "$key" --arg value "$value" --arg category "$category" --argjson sensitive "$sensitive" '{
        data: {
            type: "vars",
            attributes: {
                key: $key,
                value: $value,
                category: $category,
                hcl: false,
                sensitive: $sensitive
            }
        }
    }')

    response=$(curl -s -X POST "$api_endpoint" \
        -H "Authorization: Bearer $TFE_TOKEN" \
        -H "Content-Type: application/vnd.api+json" \
        -d "$payload")

    echo "Setting var: $key, with response: $response"
}

# Set the workspace variables
set_workspace_variable "ARM_CLIENT_ID" "$ARM_CLIENT_ID"
set_workspace_variable "ARM_CLIENT_SECRET" "$ARM_CLIENT_SECRET" "env" true
set_workspace_variable "ARM_SUBSCRIPTION_ID" "$ARM_SUBSCRIPTION_ID"
set_workspace_variable "ARM_TENANT_ID" "$ARM_TENANT_ID"

################################
# Add the workspace to a project
################################

project_url="${BASE_PROJECT_URL}/projects/${PROJECT_ID}/relationships/workspaces"
payload=$(jq -n --arg workspace_id "$workspace_id" '{
  data: [
    {
      id: $workspace_id,
      type: "workspaces"
    }
  ]
}')

echo "$project_url"
echo "$payload"

add_response=$(curl -s -X POST "${project_url}" "${HEADERS[@]}" -d "$payload")
echo "$add_response"

if [ "$(echo "$add_response" | jq -r '.data[].id')" ]; then
  echo "Workspace '${WORKSPACE_NAME}' added to project successfully."
else
  echo "Failed to add workspace to project: $(echo "$add_response" | jq -r '.errors[].detail')"
fi