# Generate a random vm name
resource "random_string" "vm-name" {
  length  = 8
  upper   = false
  numeric  = false
  lower   = true
  special = false
}


resource "azurerm_storage_account" "Storage_account" {
    name                        = "storage${random_string.vm-name.result}backup"
    resource_group_name         = var.name_resource_group
    location                    = var.location
    account_tier                = "Standard"
    account_replication_type    = "GRS"
    
    #blob_properties {
     # cors_rule { 
      #  allowed_methods = ["PUT","GET","HEAD","MERGE"]
      #}
 #   }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "copy"
  storage_account_name  = azurerm_storage_account.Storage_account.name
  container_access_type = "blob"
}