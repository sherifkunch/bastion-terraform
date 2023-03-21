output "public_subnet_id" {
   value = azurerm_subnet.my_public_terraform_subnet.id
}
output "bastion_subnet_id" {
   value = azurerm_subnet.bastion_subnet.id
}