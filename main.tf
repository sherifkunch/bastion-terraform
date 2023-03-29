
## This is the main terraform configuration file
## Most stuff should be abstracted by modules
locals {
  tf_config = jsondecode(file(var.config_file_location))
}

 module "azure-core-infra" {
 source                                   = "./modules/azure-core-infra"
 resource_group_location                  = local.tf_config.azure-core-infra.resource_group_location
 resource_group_name                      = local.tf_config.azure-core-infra.resource_group_name  
 vnet_network_name                        = local.tf_config.azure-core-infra.vnet_network_name
 address_space                            = local.tf_config.azure-core-infra.vnet_address_space
 public_address_prefix                    = local.tf_config.azure-core-infra.subnet_address_prefix_public
 private_address_prefix                   = local.tf_config.azure-core-infra.subnet_address_prefix_private
 bastion_address_prefix                   = local.tf_config.azure-core-infra.subnet_address_prefix_bastion
 bastion_subnet_name                      = local.tf_config.azure-core-infra.bastion_subnet_name
 public_subnet_name                       = local.tf_config.azure-core-infra.public_subnet_name
 private_subnet_name                      = local.tf_config.azure-core-infra.private_subnet_name
 nic_name                                 = local.tf_config.azure-core-infra.my_nic.name
 nic_ip_configuration_name                = local.tf_config.azure-core-infra.my_nic.ip_configuration.name
 nic_private_ip_address_allocation        = local.tf_config.azure-core-infra.my_nic.ip_configuration.private_ip_address_allocation
 taglist                                  = local.tf_config.main.taglist
}
module "bastion-host" {
  source                       = "./modules/bastion-host"
  bastion_name                 = local.tf_config.bastion_host.name
  bastion_tunneling_setting    = local.tf_config.bastion_host.tunneling_enabled
  bastion_sku                  = local.tf_config.bastion_host.sku
  public_ip_name               = local.tf_config.public_ip.name
  public_ip_allocation_method  = local.tf_config.public_ip.allocation_method
  public_ip_sku                = local.tf_config.public_ip.sku
  public_ip_configuration      = local.tf_config.public_ip.ip_configuration.name
  resource_group_location      = local.tf_config.azure-core-infra.resource_group_location
  resource_group_name          = local.tf_config.azure-core-infra.resource_group_name
  subnet_id                    = module.azure-core-infra.bastion_subnet_id
  depends_on = [
   module.azure-core-infra
 ]
}
module "dtp-virtual-machine" {
 source                                                      = "./modules/dtp-virtual-machine"
 resource_group_location                                     = local.tf_config.azure-core-infra.resource_group_location
 resource_group_name                                         = local.tf_config.azure-core-infra.resource_group_name  
 dtp_vm_name                                                 = local.tf_config.virtual-machine.name
 dtp_vm_size                                                 = local.tf_config.virtual-machine.size
 #OS DISK                            
 os_disk_name                                                = local.tf_config.virtual-machine.os_disk.name
 os_disk_caching                                             = local.tf_config.virtual-machine.os_disk.caching
 os_disk_storage_account_type                                = local.tf_config.virtual-machine.os_disk.storage_account_type
 #SOURCE IMAGE                             
 source_image_publisher                                      = local.tf_config.virtual-machine.source_image_reference.publisher
 source_image_offer                                          = local.tf_config.virtual-machine.source_image_reference.offer
 source_image_sku                                            = local.tf_config.virtual-machine.source_image_reference.sku
 source_image_version                                        = local.tf_config.virtual-machine.source_image_reference.version                
 computer_name                                               = local.tf_config.virtual-machine.computer_name
 admin_username                                              = local.tf_config.virtual-machine.admin_username
 disable_password_authentication                             = local.tf_config.virtual-machine.disable_password_authentication
 admin_ssh_key_username                                      = local.tf_config.virtual-machine.admin_ssh_key.name
 #NSG                            
 nsg_name                                                    = local.tf_config.virtual-machine.network_security_group.name
 nsg_ssh_rule_name                                           = local.tf_config.virtual-machine.network_security_group.ssh_rule.name
 nsg_ssh_rule_priority                                       = local.tf_config.virtual-machine.network_security_group.ssh_rule.priority
 nsg_ssh_rule_direction                                      = local.tf_config.virtual-machine.network_security_group.ssh_rule.direction
 nsg_ssh_rule_access                                         = local.tf_config.virtual-machine.network_security_group.ssh_rule.access
 nsg_ssh_rule_protocol                                       = local.tf_config.virtual-machine.network_security_group.ssh_rule.protocol
 nsg_ssh_rule_source_port_range                              = local.tf_config.virtual-machine.network_security_group.ssh_rule.source_port_range
 nsg_ssh_rule_destination_port_range                         = local.tf_config.virtual-machine.network_security_group.ssh_rule.destination_port_range
 nsg_ssh_rule_source_address_prefix                          = local.tf_config.virtual-machine.network_security_group.ssh_rule.source_address_prefix
 nsg_ssh_rule_destination_address_prefix                     = local.tf_config.virtual-machine.network_security_group.ssh_rule.destination_address_prefix

 network_interface_id                                        = module.azure-core-infra.my_terraform_nic_id
 network_security_group_id                                   = module.dtp-virtual-machine.network_security_group_id
 
 depends_on = [
   module.azure-core-infra
 ]
}
