
## This is the main terraform configuration file
## Most stuff should be abstracted by modules
locals {
  tf_config = jsondecode(file(var.config_file_location))
}
 module "azure-core-infra" {
 source                  = "./modules/azure-core-infra"
 resource_group_location = local.tf_config.azure-core-infra.resource_group_location
 resource_group_name     = local.tf_config.azure-core-infra.resource_group_name  
 vnet_network_name       = local.tf_config.azure-core-infra.vnet_network_name
 address_space           = local.tf_config.azure-core-infra.vnet_address_space
 public_address_prefix   = local.tf_config.azure-core-infra.subnet_address_prefix_public
 private_address_prefix  = local.tf_config.azure-core-infra.subnet_address_prefix_private
 public_subnet_name      = local.tf_config.azure-core-infra.public_subnet_name
 private_subnet_name     = local.tf_config.azure-core-infra.private_subnet_name
 taglist                 = local.tf_config.main.taglist
}
module "bastion-host" {
  source                  = "./modules/bastion-host"
  resource_group_location = local.tf_config.azure-core-infra.resource_group_location
  resource_group_name     = local.tf_config.azure-core-infra.resource_group_name
  subnet_id               = module.azure-core-infra.bastion_subnet_id
}

module "dtp-loadbalancer" {
 source                                             = "./modules/dtp-loadbalancer"
 subnet_id                                          = module.azure-core-infra.public_subnet_id
 #RESOURCE GROUP      
 resource_group_location                            = local.tf_config.azure-core-infra.resource_group_location
 resource_group_name                                = local.tf_config.azure-core-infra.resource_group_name  
 #PUBLIC IP     
 public-ip-sku                                      = local.tf_config.public-ip.sku
 allocation_method                                  = local.tf_config.public-ip.allocation_method
 public-ip-name                                     = local.tf_config.public-ip.name
 #LOADBALANCER RELATED      
 loadbalancer-name                                  = local.tf_config.azure-load-balancer.name
 loadbalancer-sku                                   = local.tf_config.azure-load-balancer.sku
 frontend_ip_configuration_name                     = local.tf_config.frontend_ip_configuration.name
 backend_adress_pool_name                           = local.tf_config.azure-load-balancer.backend_adress_pool_name
 #HTTPS PROBE     
 loadbalancer-https-probe-name                      = local.tf_config.azure-load-balancer.loadbalancer-probes.https-probe.name
 loadbalancer-https-probe-protocol                  = local.tf_config.azure-load-balancer.loadbalancer-probes.https-probe.protocol
 loadbalancer-https-probe-port                      = local.tf_config.azure-load-balancer.loadbalancer-probes.https-probe.port
 loadbalancer-https-probe-request-path              = local.tf_config.azure-load-balancer.loadbalancer-probes.https-probe.request_path
 #HTTP PROBE      
 loadbalancer-http-probe-name                       = local.tf_config.azure-load-balancer.loadbalancer-probes.http-probe.name
 loadbalancer-http-probe-protocol                   = local.tf_config.azure-load-balancer.loadbalancer-probes.http-probe.protocol
 loadbalancer-http-probe-port                       = local.tf_config.azure-load-balancer.loadbalancer-probes.http-probe.port
 loadbalancer-http-probe-request-path               = local.tf_config.azure-load-balancer.loadbalancer-probes.http-probe.request_path
 # LOADBALANCER RULES WEB-TO-LOADBALANCER
 web-to-loadbancer-rule-name                        = local.tf_config.azure-load-balancer.loadbalancer-rules.web-to-loadbancer.name
 web-to-loadbancer-rule-protocol                    = local.tf_config.azure-load-balancer.loadbalancer-rules.web-to-loadbancer.protocol
 web-to-loadbancer-rule-frontend_port               = local.tf_config.azure-load-balancer.loadbalancer-rules.web-to-loadbancer.frontend_port
 web-to-loadbancer-rule-backend_port                = local.tf_config.azure-load-balancer.loadbalancer-rules.web-to-loadbancer.backend_port
 web-to-loadbancer-rule-disable_outbound_snat       = local.tf_config.azure-load-balancer.loadbalancer-rules.web-to-loadbancer.disable_outbound_snat
 web-to-loadbancer-rule-enable_tcp_reset            = local.tf_config.azure-load-balancer.loadbalancer-rules.web-to-loadbancer.enable_tcp_reset
 #LOADBALANCER RULES LOADBALANCER-TO-SERVER
 loadbalancer-to-server-rule-name                   = local.tf_config.azure-load-balancer.loadbalancer-rules.loadbalancer-to-server.name
 loadbalancer-to-server-rule-protocol               = local.tf_config.azure-load-balancer.loadbalancer-rules.loadbalancer-to-server.protocol
 loadbalancer-to-server-rule-frontend_port          = local.tf_config.azure-load-balancer.loadbalancer-rules.loadbalancer-to-server.frontend_port
 loadbalancer-to-server-rule-backend_port           = local.tf_config.azure-load-balancer.loadbalancer-rules.loadbalancer-to-server.backend_port
 loadbalancer-to-server-rule-disable_outbound_snat  = local.tf_config.azure-load-balancer.loadbalancer-rules.loadbalancer-to-server.disable_outbound_snat
 loadbalancer-to-server-rule-enable_tcp_reset       = local.tf_config.azure-load-balancer.loadbalancer-rules.loadbalancer-to-server.enable_tcp_reset
 #LOADBALANCER NAT RULE 
 loadbalancer-nat-rule-name                         = local.tf_config.azure-load-balancer.loadbalancer-nat-rule.name
 loadbalancer-nat-rule-protocol                     = local.tf_config.azure-load-balancer.loadbalancer-nat-rule.protocol
 loadbalancer-nat-rule-frontend_port                = local.tf_config.azure-load-balancer.loadbalancer-nat-rule.frontend_port  
 loadbalancer-nat-rule-backend_port                 = local.tf_config.azure-load-balancer.loadbalancer-nat-rule.backend_port  
 #OUTBOUND RULE
 loadbalancer-outbount-rule-name                    = local.tf_config.azure-load-balancer.loadbalancer-outbound-rule.name
 loadbalancer-outbount-rule-protocol                = local.tf_config.azure-load-balancer.loadbalancer-outbound-rule.protocol
 #LOADBALANCER NIC
 nic-name                                           = local.tf_config.azure-load-balancer.loadbalancer-nic.name
 nic-private_ip_address_allocation                  = local.tf_config.azure-load-balancer.loadbalancer-nic.private_ip_address_allocation
 taglist                                            = local.tf_config.main.taglist
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

 nsg_any_custom_8080_inbound_rule_name                       = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.name
 nsg_any_custom_8080_inbound_rule_priority                   = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.priority
 nsg_any_custom_8080_inbound_rule_direction                  = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.direction
 nsg_any_custom_8080_inbound_rule_access                     = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.access
 nsg_any_custom_8080_inbound_rule_protocol                   = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.protocol
 nsg_any_custom_8080_inbound_rule_source_port_range          = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.source_port_range
 nsg_any_custom_8080_inbound_rule_destination_port_range     = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.destination_port_range
 nsg_any_custom_8080_inbound_rule_source_address_prefix      = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.source_address_prefix
 nsg_any_custom_8080_inbound_rule_destination_address_prefix = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8080Inbound.destination_address_prefix

 nsg_any_custom_80_inbound_rule_name                         = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.name
 nsg_any_custom_80_inbound_rule_priority                     = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.priority
 nsg_any_custom_80_inbound_rule_direction                    = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.direction
 nsg_any_custom_80_inbound_rule_access                       = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.access
 nsg_any_custom_80_inbound_rule_protocol                     = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.protocol
 nsg_any_custom_80_inbound_rule_source_port_range            = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.source_port_range
 nsg_any_custom_80_inbound_rule_destination_port_range       = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.destination_port_range
 nsg_any_custom_80_inbound_rule_source_address_prefix        = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.source_address_prefix
 nsg_any_custom_80_inbound_rule_destination_address_prefix   = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom80Inbound.destination_address_prefix

 nsg_any_custom_8443_inbound_rule_name                       = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.name
 nsg_any_custom_8443_inbound_rule_priority                   = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.priority
 nsg_any_custom_8443_inbound_rule_direction                  = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.direction
 nsg_any_custom_8443_inbound_rule_access                     = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.access
 nsg_any_custom_8443_inbound_rule_protocol                   = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.protocol
 nsg_any_custom_8443_inbound_rule_source_port_range          = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.source_port_range
 nsg_any_custom_8443_inbound_rule_destination_port_range     = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.destination_port_range
 nsg_any_custom_8443_inbound_rule_source_address_prefix      = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.source_address_prefix
 nsg_any_custom_8443_inbound_rule_destination_address_prefix = local.tf_config.virtual-machine.network_security_group.AllowAnyCustom8443Inbound.destination_address_prefix

 network_interface_id                                        = module.dtp-loadbalancer.network_interface_id
 network_security_group_id                                   = module.dtp-virtual-machine.network_security_group_id
 
 depends_on = [
   module.azure-core-infra
 ]

 #taglist                                                     = local.tf_config.main.taglist
}
