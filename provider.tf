terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
 
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "${{ value.organization }}"
    workspaces {
      name = ""${{ value.workspace }}""
    }    
  }
}

provider "azurerm" {
  features {
  }
}