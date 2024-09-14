terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }

  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

# data "terraform_remote_state" "local" {
#   backend = "local"

#   config = {
#      path = "./terraform.sub.tfstate"
#   }
# }
