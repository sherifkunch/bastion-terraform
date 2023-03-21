# # Resource-1: Create Public IP Address for Azure Load Balancer
# resource "azurerm_public_ip" "web_lbpublicip" {
#   name                = "dtp-lbpublicip"
#   resource_group_name = azurerm_resource_group.dtp-poc.name
#   location            = azurerm_resource_group.dtp-poc.location
#   allocation_method   = "Static"
#   sku = "Standard"
# }

# # Resource-2: Create Azure Standard Load Balancer
# resource "azurerm_lb" "web_lb" {
#   name                = "dtp-LoadBalancer"
#   location            = azurerm_resource_group.dtp-poc.location
#   resource_group_name = azurerm_resource_group.dtp-poc.name
#   sku = "Standard"
#   frontend_ip_configuration {
#     name                 = "web-lb-publicip-1"
#     public_ip_address_id = azurerm_public_ip.web_lbpublicip.id
#   }
# }

# # Resource-3: Create LB Backend Pool
# resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
#   name                = "web-backend"
#   loadbalancer_id     = azurerm_lb.web_lb.id
# }

# # Resource-4: Create LB Probe
# resource "azurerm_lb_probe" "web_lb_probe" {
#   name                = "https-probe"
#   protocol            = "HTTPS"
#   port                = 8443
#   loadbalancer_id     = azurerm_lb.web_lb.id
#   resource_group_name = azurerm_resource_group.dtp-poc.name
#   request_path        = "/"
# }

# resource "azurerm_lb_probe" "web_lb_probe2" {
#   name                = "http-probe"
#   protocol            = "HTTP"
#   port                = 8080
#   loadbalancer_id     = azurerm_lb.web_lb.id
#   resource_group_name = azurerm_resource_group.dtp-poc.name
#   request_path        = "/"
# }

# # Resource-5: Create LB Rule
# resource "azurerm_lb_rule" "web_lb_rule_app1" {
#   name                           = "web-app1-rule"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 8080
#   frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#   backend_address_pool_id        = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id 
#   probe_id                       = azurerm_lb_probe.web_lb_probe2.id
#   loadbalancer_id                = azurerm_lb.web_lb.id
#   resource_group_name            = azurerm_resource_group.dtp-poc.name
#   disable_outbound_snat          = true
#   enable_tcp_reset               = true

# }
# resource "azurerm_lb_rule" "web_lb_rule_app2" {
#   name                           = "web-app2-rule"
#   protocol                       = "Tcp"
#   frontend_port                  = 8443
#   backend_port                   = 8443
#   frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#   backend_address_pool_id        = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id 
#   probe_id                       = azurerm_lb_probe.web_lb_probe.id
#   loadbalancer_id                = azurerm_lb.web_lb.id
#   resource_group_name            = azurerm_resource_group.dtp-poc.name
#   disable_outbound_snat          = true
#   enable_tcp_reset               = true
# }

# # Adding NAT rule so we can ssh to the VM through the public IP of the LB 
# resource "azurerm_lb_nat_rule" "example" {
#   resource_group_name            = azurerm_resource_group.dtp-poc.name
#   loadbalancer_id                = azurerm_lb.web_lb.id
#   name                           = "SSHAccess"
#   protocol                       = "Tcp"
#   frontend_port                  = 221
#   backend_port                   = 22
#   frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
# }

# #OUTBOUND RULE
# resource "azurerm_lb_outbound_rule" "outboundruleDtp" {
#   name                    = "AllowAccessToTheInternet"
#   resource_group_name     = azurerm_resource_group.dtp-poc.name
#   loadbalancer_id         = azurerm_lb.web_lb.id
#   protocol                = "All"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
  
#    frontend_ip_configuration {
#     name                 = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#   }
# }

# resource "azurerm_network_interface" "lv-nic" {
#   name                = "dtp-lb-nic"
#   location            = azurerm_resource_group.dtp-poc.location
#   resource_group_name = azurerm_resource_group.dtp-poc.name


#   ip_configuration {
#     name                          = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#     subnet_id                     = azurerm_subnet.my_public_terraform_subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }
# # Resource-6: Associate Network Interface and Standard Load Balancer
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association
# resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
#   network_interface_id    = azurerm_network_interface.lv-nic.id
#   ip_configuration_name   = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
# }

# resource "azurerm_network_interface_nat_rule_association" "example" {
#   network_interface_id  = azurerm_network_interface.lv-nic.id
#   ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#   nat_rule_id           = azurerm_lb_nat_rule.example.id
# }