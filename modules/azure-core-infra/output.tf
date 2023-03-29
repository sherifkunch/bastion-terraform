output "public_subnet_id" {
   value = azurerm_subnet.my_public_terraform_subnet.id
}
output "bastion_subnet_id" {
   value = azurerm_subnet.bastion_subnet.id
}
output "private_subnet_id" {
   value = azurerm_subnet.my_private_terraform_subnet.id
}
output "my_terraform_nic_id" {
   value = azurerm_network_interface.my_nic.id
}
