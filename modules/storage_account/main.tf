# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    //name                = "${var.storagename}"
    count               = "${length(var.StoragesName)}"
    name                = "${element(var.StoragesName, count.index)}"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    # required by new version of azurerm
    account_tier          = "Standard"
    account_replication_type = "GRS"
    tags = "${var.Tags}"
}

resource "azurerm_storage_container" "mystoragecontainer" {
  name                  = "principal"
  count                 = "${length(var.StoragesName)}"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${element(var.StoragesName, count.index)}"
  container_access_type = "private"
}
/*
resource "azurerm_storage_blob" "mystorageblob" {
  name = "sample.vhd"

  resource_group_name    = "${var.resource_group_name}"
  storage_account_name   = "${azurerm_storage_account.mystorageaccount.name}"
  storage_container_name = "${azurerm_storage_container.mystoragecontainer.name}"

  type = "page"
  size = 5120
}
*/