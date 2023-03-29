resource "azurerm_public_ip" "example" {
  name                = var.public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}


resource "azurerm_bastion_host" "example" {
  name                = var.bastion_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tunneling_enabled   = var.bastion_tunneling_setting
  sku                 = var.bastion_sku
  ip_configuration {
    name                 = var.public_ip_configuration
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}