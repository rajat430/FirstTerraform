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
      name = "dit"
    } 
  } 
  
}

provider "azurerm" {
  features {}
    resource_provider_registrations = "none"
      subscription_id = var.subscription_id
}