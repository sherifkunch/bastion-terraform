# # Create virtual machine
# resource "azurerm_linux_virtual_machine" "my_terraform_vm2" {
#   name                  = "my-dtp-server"
#   location              = azurerm_resource_group.dtp-poc.location
#   resource_group_name   = azurerm_resource_group.dtp-poc.name
#   network_interface_ids = [azurerm_network_interface.lv-nic.id]
#   size                  = "Standard_DS1_v2"

#   os_disk {
#     name                 = "myOsDiskDTP"
#     caching              = "ReadWrite"
#     storage_account_type = "Premium_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   computer_name                   = "dtp-server-2"
#   admin_username                  = "azureuser"
#   disable_password_authentication = true

#   admin_ssh_key {
#     username   = "azureuser"
#     public_key = tls_private_key.example_ssh.public_key_openssh
#   }  
# }

# resource "azurerm_network_security_group" "my_terraform_nsg" {
#   name                = "DTP_NSG"
#   location            = azurerm_resource_group.dtp-poc.location
#   resource_group_name = azurerm_resource_group.dtp-poc.name

#   security_rule {
#     name                       = "SSH"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "AllowAnyCustom8080Inbound"
#     priority                   = 101
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "8080"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "AllowAnyCustom80Inbound"
#     priority                   = 102
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "AllowAnyCustom8443Inbound"
#     priority                   = 104
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "8443"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }
# # Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "vmToNsg" {
#   network_interface_id      = azurerm_network_interface.lv-nic.id
#   network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
# }

# # Create (and display) an SSH key
# resource "tls_private_key" "example_ssh" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# # Provide the ssh locally
# resource "local_sensitive_file" "ansible_admin_private_sshkey" {
#   content = tls_private_key.example_ssh.private_key_pem
#   filename = "./files/ssh-key"
#   file_permission = "0600"
# }

# resource "local_file" "ansible_admin_public_sshkey" {
#   content = tls_private_key.example_ssh.public_key_pem
#   filename = "./files/key.pub"
#   file_permission = "0600"
# }