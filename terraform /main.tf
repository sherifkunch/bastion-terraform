
# resource "azurerm_resource_group" "dtp-poc" {
#   location = local.resource_group_location
#   name     = "poc-dtp"
# }

# # Create virtual network
# resource "azurerm_virtual_network" "my_terraform_network" {
#   name                = "my-DTP-Vnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.dtp-poc.location
#   resource_group_name = azurerm_resource_group.dtp-poc.name
# }

# # Create subnet
# resource "azurerm_subnet" "my_public_terraform_subnet" {
#   name                 = "my-public-subnet"
#   resource_group_name  = azurerm_resource_group.dtp-poc.name
#   virtual_network_name = azurerm_virtual_network.my_terraform_network.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# # Create private subnet
# resource "azurerm_subnet" "my_private_terraform_subnet" {
#   name                 = "my-private-Subnet"
#   resource_group_name  = azurerm_resource_group.dtp-poc.name
#   virtual_network_name = azurerm_virtual_network.my_terraform_network.name
#   address_prefixes     = ["10.0.2.0/24"]
# }
