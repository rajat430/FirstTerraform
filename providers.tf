terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }

  cloud { 
    organization = "rajat430" 
    workspaces { 
      name = "dit-cli"
    } 
  } 
  
}

provider "azurerm" {
  features {}
    resource_provider_registrations = "none"
}