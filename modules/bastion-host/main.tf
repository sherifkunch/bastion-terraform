resource "azurerm_public_ip" "example" {
  name                = "examplepip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_bastion_host" "example" {
  name                = "examplebastion"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tunneling_enabled   = true
  sku                 = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}