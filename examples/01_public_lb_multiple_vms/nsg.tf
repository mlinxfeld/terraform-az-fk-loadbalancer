resource "azurerm_network_security_group" "fk_subnet_private_nsg" {
  name                = "${var.vm_name}-nsg"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name

  security_rule {
    name                       = "allow-http-from-azure-lb"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http-from-internet"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"   
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "fk_subnet_private_nsg_assoc" {
  subnet_id                 = module.vnet.subnet_ids["fk-subnet-private"]
  network_security_group_id = azurerm_network_security_group.fk_subnet_private_nsg.id
}