variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}
variable "resource_group_name" {
  description = "Resource groupe name."
}
variable "dtp_vm_name" {
  description = "The name of the virtual machine."
}

variable "dtp_vm_size" {
  description = "Specifies the size of the virtual machine."
}

variable "os_disk_name" {
  description = "Specifies the name of the virtual machine disk."
}
variable "os_disk_caching" {
  description = "Specifies the caching requirements for the Data Disk. Possible values include None, ReadOnly and ReadWrite."
}
variable "os_disk_storage_account_type" {
  description = "Disk storage account type"
}
variable "source_image_publisher" {
  description = "publisher - (Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created."
}
variable "source_image_offer" {
  description = "offer - (Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created."
}
variable "source_image_sku" {
  description = "sku - (Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created."
}
variable "source_image_version" {
  description = "version - (Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created."
}
variable "computer_name" {
  description = "computer_name - (Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created."
}
variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}
variable "disable_password_authentication" {
  description = "true or false"
}
#NSG

variable "nsg_name" {
  description = " Specifies the name of the network security group. Changing this forces a new resource to be created."
}
#SSH_NSG
variable "nsg_ssh_rule_name" {
  description = " (Required) The name of the security rule."
}
variable "nsg_ssh_rule_priority" {
  description = "(Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."
}
variable "nsg_ssh_rule_direction" {
  description = "(Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound"
}
variable "nsg_ssh_rule_access" {
  description = "(Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."
}
variable "nsg_ssh_rule_protocol" {
  description = "(Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)."
}
variable "nsg_ssh_rule_source_port_range" {
  description = "(Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified."
}
variable "nsg_ssh_rule_destination_port_range" {
  description = " (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified."
} 
variable "nsg_ssh_rule_source_address_prefix" {
  description = "(Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified."
} 
variable "nsg_ssh_rule_destination_address_prefix" {
  description = "(Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if destination_address_prefixes is not specified."
}

variable network_interface_id {
    description ="network interface ID"
}
variable network_security_group_id {
    description ="network security group id"
}
variable "admin_ssh_key_username" {
  description = "The usernameof admin ssh key"
}
