# Create virtual machine
resource "azurerm_linux_virtual_machine" "dtp_server" {
  name                  = var.dtp_vm_name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [var.network_interface_id]
  size                  = var.dtp_vm_size

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  computer_name                   = var.computer_name
  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_password_authentication

  admin_ssh_key {
    username   = var.admin_ssh_key_username
    public_key = tls_private_key.example_ssh.public_key_openssh
  }  
}

resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = var.nsg_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = var.nsg_ssh_rule_name
    priority                   = var.nsg_ssh_rule_priority
    direction                  = var.nsg_ssh_rule_direction
    access                     = var.nsg_ssh_rule_access
    protocol                   = var.nsg_ssh_rule_protocol
    source_port_range          = var.nsg_ssh_rule_source_port_range
    destination_port_range     = var.nsg_ssh_rule_destination_port_range
    source_address_prefix      = var.nsg_ssh_rule_source_address_prefix
    destination_address_prefix = var.nsg_ssh_rule_destination_address_prefix
  }
  security_rule {
    name                       = var.nsg_any_custom_80_inbound_rule_name
    priority                   = var.nsg_any_custom_80_inbound_rule_priority
    direction                  = var.nsg_any_custom_80_inbound_rule_direction
    access                     = var.nsg_any_custom_80_inbound_rule_access
    protocol                   = var.nsg_any_custom_80_inbound_rule_protocol
    source_port_range          = var.nsg_any_custom_80_inbound_rule_source_port_range
    destination_port_range     = var.nsg_any_custom_80_inbound_rule_destination_port_range
    source_address_prefix      = var.nsg_any_custom_80_inbound_rule_source_address_prefix
    destination_address_prefix = var.nsg_any_custom_80_inbound_rule_destination_address_prefix
  }
}
# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "vmToNsg" {
  network_interface_id      = var.network_interface_id
  network_security_group_id = var.network_security_group_id
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Provide the ssh locally
resource "local_sensitive_file" "ansible_admin_private_sshkey" {
  content = tls_private_key.example_ssh.private_key_pem
  filename = "./files/ssh-key"
  file_permission = "0600"
}

resource "local_file" "ansible_admin_public_sshkey" {
  content = tls_private_key.example_ssh.public_key_pem
  filename = "./files/key.pub"
  file_permission = "0600"
}