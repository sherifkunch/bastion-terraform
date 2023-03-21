# Resource-1: Create Public IP Address for Azure Load Balancer
resource "azurerm_public_ip" "web_lbpublicip" {
  name                = var.public-ip-name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = var.allocation_method
  sku                 = var.public-ip-sku
  tags                = "${var.taglist}"
}

# Resource-2: Create Azure Standard Load Balancer
resource "azurerm_lb" "web_lb" {
  name                = var.loadbalancer-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.loadbalancer-sku
  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.web_lbpublicip.id
  }
  tags     = "${var.taglist}"
}

# Resource-3: Create LB Backend Pool
resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
  name                = var.backend_adress_pool_name
  loadbalancer_id     = azurerm_lb.web_lb.id
}

# Resource-4: Create LB Probe
resource "azurerm_lb_probe" "https_lb_probe" {
  name                = var.loadbalancer-https-probe-name
  protocol            = var.loadbalancer-https-probe-protocol
  port                = var.loadbalancer-https-probe-port
  loadbalancer_id     = azurerm_lb.web_lb.id
  resource_group_name = var.resource_group_name
  request_path        = var.loadbalancer-https-probe-request-path
}

resource "azurerm_lb_probe" "http_lb_probe" {
  name                = var.loadbalancer-http-probe-name
  protocol            = var.loadbalancer-http-probe-protocol
  port                = var.loadbalancer-http-probe-port
  loadbalancer_id     = azurerm_lb.web_lb.id
  resource_group_name = var.resource_group_name
  request_path        = var.loadbalancer-http-probe-request-path
}

# Resource-5: Create LB Rule
resource "azurerm_lb_rule" "web-to-loadbalancer" {
  name                           = var.web-to-loadbancer-rule-name 
  protocol                       = var.web-to-loadbancer-rule-protocol 
  frontend_port                  = var.web-to-loadbancer-rule-frontend_port
  backend_port                   = var.web-to-loadbancer-rule-backend_port 
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id] 
  probe_id                       = azurerm_lb_probe.https_lb_probe.id
  loadbalancer_id                = azurerm_lb.web_lb.id
  resource_group_name            = var.resource_group_name
  disable_outbound_snat          = var.web-to-loadbancer-rule-disable_outbound_snat
  enable_tcp_reset               = var.web-to-loadbancer-rule-enable_tcp_reset
}
resource "azurerm_lb_rule" "web_lb_rule_app2" {
  name                           = var.loadbalancer-to-server-rule-name 
  protocol                       = var.loadbalancer-to-server-rule-protocol 
  frontend_port                  = var.loadbalancer-to-server-rule-frontend_port
  backend_port                   = var.loadbalancer-to-server-rule-backend_port 
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id] 
  probe_id                       = azurerm_lb_probe.http_lb_probe.id
  loadbalancer_id                = azurerm_lb.web_lb.id
  resource_group_name            = var.resource_group_name
  disable_outbound_snat          = var.loadbalancer-to-server-rule-disable_outbound_snat
  enable_tcp_reset               = var.loadbalancer-to-server-rule-enable_tcp_reset
}

# Adding NAT rule so we can ssh to the VM through the public IP of the LB 
resource "azurerm_lb_nat_rule" "allow-ssh" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.web_lb.id
  name                           = var.loadbalancer-nat-rule-name  
  protocol                       = var.loadbalancer-nat-rule-protocol
  frontend_port                  = var.loadbalancer-nat-rule-frontend_port
  backend_port                   = var.loadbalancer-nat-rule-backend_port 
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
}

#OUTBOUND RULE
resource "azurerm_lb_outbound_rule" "outboundruleDtp" {
  name                    = var.loadbalancer-outbount-rule-name 
  resource_group_name     = var.resource_group_name
  loadbalancer_id         = azurerm_lb.web_lb.id
  protocol                = var.loadbalancer-outbount-rule-protocol
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
  
   frontend_ip_configuration {
    name                 = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  }
}

resource "azurerm_network_interface" "lv-nic" {
  name                = var.nic-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  ip_configuration {
    name                          = azurerm_lb.web_lb.frontend_ip_configuration[0].name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.nic-private_ip_address_allocation
  }
}
# Resource-6: Associate Network Interface and Standard Load Balancer
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association
resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  network_interface_id    = azurerm_network_interface.lv-nic.id
  ip_configuration_name   = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
}

resource "azurerm_network_interface_nat_rule_association" "example" {
  network_interface_id  = azurerm_network_interface.lv-nic.id
  ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  nat_rule_id           = azurerm_lb_nat_rule.allow-ssh.id
}