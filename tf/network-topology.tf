resource "azurerm_virtual_network" "onpremise-vnet" {
  name                = "onpremise-vnet"
  location            = azurerm_resource_group.onpremise-rg.location
  resource_group_name = azurerm_resource_group.onpremise-rg.name
  address_space       = ["10.233.0.0/21"]
}

resource "azurerm_subnet" "onpremise-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.onpremise-rg.name
  virtual_network_name = azurerm_virtual_network.onpremise-vnet.name
  address_prefixes     = ["10.233.0.0/26"]
}

resource "azurerm_subnet" "onpremise-default-subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.onpremise-rg.name
  virtual_network_name = azurerm_virtual_network.onpremise-vnet.name
  address_prefixes     = ["10.233.1.0/24"]
}

resource "azurerm_virtual_network" "hub-vnet" {
  name                = "hub-vnet"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  address_space       = ["10.221.0.0/21"]
}

resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.221.0.0/26"]
}

resource "azurerm_subnet" "hub-default-subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = ["10.221.1.0/24"]
}

resource "azurerm_virtual_network" "spoke01-vnet" {
  name                = "spoke01-vnet"
  location            = azurerm_resource_group.spoke01-rg.location
  resource_group_name = azurerm_resource_group.spoke01-rg.name
  address_space       = ["10.222.0.0/21"]
}

resource "azurerm_subnet" "spoke01-default-subnet" {
  name                                      = "default"
  resource_group_name                       = azurerm_resource_group.spoke01-rg.name
  virtual_network_name                      = azurerm_virtual_network.spoke01-vnet.name
  address_prefixes                          = ["10.222.1.0/24"]
  private_endpoint_network_policies_enabled = true
}

resource "azurerm_virtual_network" "spoke02-vnet" {
  name                = "spoke02-vnet"
  location            = azurerm_resource_group.spoke02-rg.location
  resource_group_name = azurerm_resource_group.spoke02-rg.name
  address_space       = ["10.223.0.0/21"]
}

resource "azurerm_subnet" "spoke02-default-subnet" {
  name                                      = "default"
  resource_group_name                       = azurerm_resource_group.spoke02-rg.name
  virtual_network_name                      = azurerm_virtual_network.spoke02-vnet.name
  address_prefixes                          = ["10.223.1.0/24"]
  private_endpoint_network_policies_enabled = true
}

resource "azurerm_virtual_network" "spoke03-vnet" {
  name                = "spoke03-vnet"
  location            = azurerm_resource_group.spoke03-rg.location
  resource_group_name = azurerm_resource_group.spoke03-rg.name
  address_space       = ["10.224.0.0/21"]
}

resource "azurerm_subnet" "spoke03-default-subnet" {
  name                                      = "default"
  resource_group_name                       = azurerm_resource_group.spoke03-rg.name
  virtual_network_name                      = azurerm_virtual_network.spoke03-vnet.name
  address_prefixes                          = ["10.224.1.0/24"]
  private_endpoint_network_policies_enabled = true
}

resource "azurerm_virtual_network_peering" "spoke01-hub" {
  name                         = "PEERING_SPOKE01_TO_HUB"
  resource_group_name          = azurerm_resource_group.spoke01-rg.name
  virtual_network_name         = azurerm_virtual_network.spoke01-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hub-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true

  depends_on = [azurerm_virtual_network_gateway.hub-vpngw]
}

resource "azurerm_virtual_network_peering" "hub-spoke01" {
  name                         = "PEERING_HUB_TO_SPOKE01"
  resource_group_name          = azurerm_resource_group.hub-rg.name
  virtual_network_name         = azurerm_virtual_network.hub-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke01-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = true
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_gateway.hub-vpngw]
}

resource "azurerm_virtual_network_peering" "spoke02-hub" {
  name                         = "PEERING_SPOKE02_TO_HUB"
  resource_group_name          = azurerm_resource_group.spoke02-rg.name
  virtual_network_name         = azurerm_virtual_network.spoke02-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hub-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true

  depends_on = [azurerm_virtual_network_gateway.hub-vpngw]
}

resource "azurerm_virtual_network_peering" "hub-spoke02" {
  name                         = "PEERING_HUB_TO_SPOKE02"
  resource_group_name          = azurerm_resource_group.hub-rg.name
  virtual_network_name         = azurerm_virtual_network.hub-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke02-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = true
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_gateway.hub-vpngw]
}

resource "azurerm_virtual_network_peering" "spoke03-hub" {
  name                         = "PEERING_SPOKE03_TO_HUB"
  resource_group_name          = azurerm_resource_group.spoke03-rg.name
  virtual_network_name         = azurerm_virtual_network.spoke03-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hub-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true

  depends_on = [azurerm_virtual_network_gateway.hub-vpngw]
}

resource "azurerm_virtual_network_peering" "hub-spoke03" {
  name                         = "PEERING_HUB_TO_SPOKE03"
  resource_group_name          = azurerm_resource_group.hub-rg.name
  virtual_network_name         = azurerm_virtual_network.hub-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke03-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = true
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_gateway.hub-vpngw]
}