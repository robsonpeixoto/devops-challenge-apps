resource "azurerm_resource_group" "database-rg" {
  name     = "database"
  location = "West Us"
}

resource "azurerm_postgresql_server" "server-db" {
  name                = "${var.server_name}"
  location            = "${azurerm_resource_group.database-rg.location}"
  resource_group_name = "${azurerm_resource_group.database-rg.name}"

  sku {
    name     = "B_Gen5_1"
    capacity = 1
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "stone"
  administrator_login_password = "r0llingSt0ne!"
  version                      = "9.5"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_database" "database" {
  name                = "rolling"
  resource_group_name = "${azurerm_resource_group.database-rg.name}"
  server_name         = "${azurerm_postgresql_server.server-db.name}"
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
