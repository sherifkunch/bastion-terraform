### CORE infrastructure:
### - azure-core-infra (networks, ip ranges, firewall rules)

# Create own resrouce group 
resource "azurerm_resource_group" "bastion-poc" {
  location = var.resource_group_location
  name     = var.resource_group_name
  tags     = var.taglist 
}

resource "azurerm_virtual_network" "vnet" {
  name                 = var.vnet_network_name
  resource_group_name  = var.resource_group_name 
  address_space        = var.address_space
  location             = var.resource_group_location
  tags                 = var.taglist
  depends_on = [
    azurerm_resource_group.bastion-poc
  ]
}

# Create public subnet
resource "azurerm_subnet" "my_public_terraform_subnet" {
  name                 = var.public_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_network_name
  address_prefixes     = var.public_address_prefix
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create private subnet
resource "azurerm_subnet" "my_private_terraform_subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_network_name
  address_prefixes     = var.private_address_prefix
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_network_name
  address_prefixes     = var.bastion_address_prefix
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create network interface
resource "azurerm_network_interface" "my_nic" {
  name                = "myNIC"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.my_private_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}