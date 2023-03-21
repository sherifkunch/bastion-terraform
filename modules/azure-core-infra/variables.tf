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

variable "taglist" {
  description = "Taglist for all resources"
  type= map(string)
}

