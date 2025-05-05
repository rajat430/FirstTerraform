data "azurerm_resource_group" "example" {
  name     = "1-7c56a92e-playground-sandbox"
}

resource "azurerm_storage_account" "example" {
  name                     = "rajatstorageacc0120"
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

module "network" {
  source  = "app.terraform.io/rajat430/network/azure"
  version = "1.0.0"
  # insert required variables here
  vnet_resource_group= data.azurerm_resource_group.example.name
  dns_servers = [ "10.0.0.4","10.0.0.5" ]
  subnet_details = {
    subnet1 = {
      name="subnet1",
      address_prefixes=["10.0.0.0/29"],
      nsg_name="nsg001",
      nsg_rules={}
    },
    subnet2={
      name="subnet2",
      address_prefixes=["10.0.0.8/29"],
      nsg_name="nsg002",
      nsg_rules={}
    }
  }
  vnet_address_space = [ "10.0.0.0/24" ]
  vnet_name = "vnet001"
}