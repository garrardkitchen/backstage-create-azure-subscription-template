terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
 
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "${{ values.organisation }}"
    workspaces {
      name = "${{ values.workspace }}"
    }    
  }
}

provider "azurerm" {
  features {
  }
}
