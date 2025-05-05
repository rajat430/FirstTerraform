terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }

  # cloud { 
  #   organization = "rajat430" 
  #   workspaces { 
  #     name = "dev"
  #   } 
  # } 
  
}

provider "azurerm" {
  features {}
    resource_provider_registrations = "none"
      client_id       = var.client_id
      client_secret   = var.client_secret
      tenant_id       = var.tenant_id
      subscription_id = var.subscription_id
}