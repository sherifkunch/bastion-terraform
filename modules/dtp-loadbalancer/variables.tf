variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}
variable "resource_group_name" {
  description = "Resource groupe name."
}
variable "allocation_method" {
  description = "Public IP firewall allocation method."
}
variable "public-ip-sku" {
  description = "Public IP SKU."
}
variable "public-ip-name" {
  description = "Public IP name."
}
variable "loadbalancer-name" {
  description = "The name of the loadbalancer"
}
variable "loadbalancer-sku" {
  description = "SKU of the loadbalancer"
}
variable "frontend_ip_configuration_name" {
  description = "name of the frontendip"
}
variable "backend_adress_pool_name" {
  description = "The name of the backend adress pool of the loadbalancer"
}
variable "loadbalancer-https-probe-name" {
  description = "The name of the https loadbalancer probe"
}
variable "loadbalancer-https-probe-protocol" {
  description = "The protocol of the https loadbalancer probe"
}
variable "loadbalancer-https-probe-port" {
  description = "The port of the https loadbalancer probe"
}
variable "loadbalancer-https-probe-request-path" {
  description = "The request path of the https loadbalancer probe"
}
variable "loadbalancer-http-probe-name" {
  description = "The name of the http loadbalancer probe"
}
variable "loadbalancer-http-probe-protocol" {
  description = "The protocol of the http loadbalancer probe"
}
variable "loadbalancer-http-probe-port" {
  description = "The port of the http loadbalancer probe"
}
variable "loadbalancer-http-probe-request-path" {
  description = "The request path of the http loadbalancer probe"
}
variable "web-to-loadbancer-rule-name" {
  description = "The loadbalancer rule name which is controlling traffic coming inbound to the loadbalancer"
}
variable "web-to-loadbancer-rule-protocol" {
  description = "The loadbalancer rule protocol which is controlling traffic coming inbound to the loadbalancer"
}                     
variable "web-to-loadbancer-rule-frontend_port" {
  description = "The loadbalancer rule frontend port which is accepting traffic coming inbound to the loadbalancer"
}                     
variable "web-to-loadbancer-rule-backend_port" {
  description = "The loadbalancer rule backend port which is forwarding traffic to the backend"
}                     
variable "web-to-loadbancer-rule-disable_outbound_snat" {
  description = "Loadbalancer rule for true/false diasbling of outbound snat"
}                      
variable "web-to-loadbancer-rule-enable_tcp_reset" {
  description = "Loadbalancer rule for true/false enabling of tcp reset"
}           
variable "loadbalancer-to-server-rule-name" {
  description = "The loadbalancer rule name which is controlling traffic coming from the loadbalancer to the server"
}    
variable "loadbalancer-to-server-rule-protocol" {
  description = "The loadbalancer rule protocol which is controlling traffic coming inbound to the loadbalancer"
}                     
variable "loadbalancer-to-server-rule-frontend_port"   {
  description = "The loadbalancer rule frontend port which is accepting traffic coming inbound to the server"
}                     
variable "loadbalancer-to-server-rule-backend_port" {
  description = "The loadbalancer rule backend port which is forwarding traffic to the backend"
} 
variable "loadbalancer-to-server-rule-disable_outbound_snat" {
  description = "Loadbalancer rule for true/false diasbling of outbound snat"
}                      
variable "loadbalancer-to-server-rule-enable_tcp_reset" {
  description = "Loadbalancer rule for true/false enabling of tcp reset"
}              
variable "loadbalancer-nat-rule-name" {
  description = "Loadbalancer nat rule used to forward traffic from a load balancer frontend to one or more instances in the backend pool. "
} 
variable "loadbalancer-nat-rule-protocol" {
  description = "Loadbalancer nat rule used to forward traffic from a load balancer frontend to one or more instances in the backend pool. "
} 
variable "loadbalancer-nat-rule-frontend_port" {
  description = "Loadbalancer nat rule frontend port allocation"
}        
variable "loadbalancer-nat-rule-backend_port" {
  description = "Loadbalancer nat rule backend port allocation"
}        
variable "loadbalancer-outbount-rule-name" {
  description = "The name of the outbound loadbalancer rule."
}   
variable "loadbalancer-outbount-rule-protocol" {
  description = "The protocol of the outbound loadbalancer rule."
}   
variable "nic-name" {
  description = "The name of the network interface card."
}   
variable "nic-private_ip_address_allocation" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
}  
variable subnet_id {
    description ="Subnet ID"
}
variable "taglist" {
  description = "Taglist for all resources"
  type = map(string)
}