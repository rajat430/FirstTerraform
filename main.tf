
# data "azurerm_resource_group" "example" {
#     name = var.vnet_resource_group
# }

data "azurerm_resource_group" "vnet_rg" {
 name =  var.vnet_resource_group
}

resource "azurerm_network_security_group" "example" {
  for_each = var.subnet_details
  name                = each.value.nsg_name
  location            = data.azurerm_resource_group.vnet_rg.location
  resource_group_name = data.azurerm_resource_group.vnet_rg.name

  security_rule = var.subnet_details.value.nsg_rules

}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.vnet_rg.location
  resource_group_name = data.azurerm_resource_group.vnet_rg.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers

  dynamic "subnet" {
    for_each = var.subnet_details 
    content {
      name = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
      security_group = azurerm_network_security_group.example[subnet.key].id
    }
  }

  tags = {
    environment = "Production"
  }
}
