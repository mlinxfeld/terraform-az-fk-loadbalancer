module "vnet" {
  source = "github.com/mlinxfeld/terraform-az-fk-vnet"

  name                = var.vnet_name
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name

  address_space = [var.vnet_address_space]
  subnets       = var.subnets

  tags = var.tags
}

resource "azurerm_nat_gateway" "foggykitchen_nat_gw" {
  name                = "foggykitchen_nat_gw"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  sku_name            = "Standard"
}

resource "azurerm_public_ip" "foggykitchen_natgw_public_ip" {
  name                = "foggykitchen_natgw_ip"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "foggykitchen_natgw_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.foggykitchen_nat_gw.id
  public_ip_address_id = azurerm_public_ip.foggykitchen_natgw_public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "private_nat_assoc" {
  subnet_id      = module.vnet.subnet_ids["fk-subnet-private"]
  nat_gateway_id = azurerm_nat_gateway.foggykitchen_nat_gw.id
}