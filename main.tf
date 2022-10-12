terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }

  backend "remote" {
    organization = "rtrm"
    workspaces {
      name = "satisfactory-server"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "ci" {
  name     = "RG-WE-D-CICD"
  location = "West Europe"
}
