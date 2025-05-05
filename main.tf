data "azurerm_resource_group" "example" {
  name     = "1-68a120af-playground-sandbox"
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
  version = "1.1.3"
  # insert required variables here
  vnet_resource_group= data.azurerm_resource_group.example.name
  dns_servers = [ "10.0.0.4","10.0.0.5" ]
  subnet_details = {
    subnet1 = {
      name="subnet1",
      address_prefixes=["10.0.0.0/29"],
      nsg_name="nsg001",
      nsg_rules=toset([
        {
          name="rule1"
          properties={
            protocol="*",
            sourcePortRange= "*"
            destinationPortRange= "8090"
            sourceAddressPrefix="*"
            destinationAddressPrefix= "*"
            access= "Allow"
            priority= 1002
            direction= "Inbound"
            sourcePortRanges= []
            destinationPortRanges= []
            sourceAddressPrefixes= []
            destinationAddressPrefixes= [] 
          }
        }
      ])
    },
    subnet2={
      name="subnet2",
      address_prefixes=["10.0.0.8/29"],
      nsg_name="nsg002",
      nsg_rules=toset([
        {
          name="rule1"
          properties={
            protocol="*",
            sourcePortRange= "*"
            destinationPortRange= "8090"
            sourceAddressPrefix="*"
            destinationAddressPrefix= "*"
            access= "Allow"
            priority= 1002
            direction= "Inbound"
            sourcePortRanges= []
            destinationPortRanges= []
            sourceAddressPrefixes= []
            destinationAddressPrefixes= []
          }
        }
      ])
    }
  }
  vnet_address_space = [ "10.0.0.0/24" ]
  vnet_name = "vnet001" 
}