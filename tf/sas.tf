resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_private_dns_zone" "privatelink_file_core_windows_net" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.spoke01-rg.name
}

resource "azurerm_storage_account" "spoke01-stracct" {
  name                     = "${random_string.random.result}saspoke01"
  resource_group_name      = azurerm_resource_group.spoke01-rg.name
  location                 = azurerm_resource_group.spoke01-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share01" {
  name                 = "share01"
  storage_account_name = azurerm_storage_account.spoke01-stracct.name
  quota                = 50
}

resource "azurerm_private_endpoint" "spoke01-sa-pe" {
  name                = "spoke01-${random_string.random.result}-sa-endpoint"
  location            = azurerm_resource_group.spoke01-rg.location
  resource_group_name = azurerm_resource_group.spoke01-rg.name
  subnet_id           = azurerm_subnet.spoke01-default-subnet.id
  private_service_connection {
    name                           = "spoke01-${random_string.random.result}-sa-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_share.share01.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-file"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_file_core_windows_net.id]
  }
}

resource "azurerm_storage_account" "spoke02-stracct" {
  name                     = "${random_string.random.result}saspoke02"
  resource_group_name      = azurerm_resource_group.spoke02-rg.name
  location                 = azurerm_resource_group.spoke02-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share02" {
  name                 = "share02"
  storage_account_name = azurerm_storage_account.spoke02-stracct.name
  quota                = 50
}

resource "azurerm_storage_account" "spoke03-stracct" {
  name                     = "${random_string.random.result}saspoke03"
  resource_group_name      = azurerm_resource_group.spoke03-rg.name
  location                 = azurerm_resource_group.spoke03-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share03" {
  name                 = "share03"
  storage_account_name = azurerm_storage_account.spoke03-stracct.name
  quota                = 50
}