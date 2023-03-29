variable "vnet_network_name" {
  description = "Name of the vnet"
}

variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  description = "Resource group name."
}

variable "address_space" {
  description = "Address space of the VNET"
}

variable "public_address_prefix" {
  description = "Address prefix of the subnet"
}

variable "private_address_prefix" {
  description = "Address prefix of the subnet"
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
}
variable "bastion_address_prefix" {
  description = "The range for the bastion subnet"
}
variable "nic_name" {
  description = "the name of the network interface card"
}
variable "nic_ip_configuration_name" {
  description = ""
}
variable "nic_private_ip_address_allocation" {
  description = ""
}                                
variable "bastion_subnet_name" {
  description = "Name of the bastion subnet"
}
variable "taglist" {
  description = "Taglist for all resources"
  type= map(string)
}

