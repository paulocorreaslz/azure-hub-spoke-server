resource "azurerm_storage_account" "storageaccountproddl" {
  name                     = "storageaccountproddl"
  resource_group_name      = azurerm_resource_group.rg-br-infra-prod.name
  location                 = azurerm_resource_group.rg-br-infra-prod.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  tags = {
    "environment" = "prod"
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "storagedatalakefs" {
  name               = "storagedatalakefs"
  storage_account_id = azurerm_storage_account.storageaccountproddl.id

#   properties = {
#     hello = "aGVsbG8="
#   }
}

resource "azurerm_storage_account_network_rules" "storageaccountnetrules" {
  resource_group_name      = azurerm_resource_group.rg-br-infra-prod.name
  storage_account_name = azurerm_storage_account.storageaccountproddl.name

  default_action             = "Allow"
  #ip_rules                   = ["172.25.0.0/16"]
  virtual_network_subnet_ids = [azurerm_subnet.subnet-grupo-data-app-prod.id]
  bypass                     = ["Metrics"]
}

resource "azurerm_storage_data_lake_gen2_path" "storagedatalakepath" {
  path               = "datalakepath"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.storagedatalakefs.name
  storage_account_id = azurerm_storage_account.storageaccountproddl.id
  resource           = "directory"
}