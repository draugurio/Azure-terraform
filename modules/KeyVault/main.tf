  resource "azurerm_key_vault" "keyvaulttest"{
    name                        = "${var.name}"
    location                    = "${var.location}"
    resource_group_name         = "${var.resource_group_name}"
    tenant_id                   = "${var.tenant_id}"
    enabled_for_disk_encryption = true
    sku_name                     = "standard"
    tags                        = "${var.Tags}"
    
    access_policy {
      tenant_id = "${var.tenant_id}"
      object_id = "95fd21ec-1ab1-41e3-8438-ecb85f541a17"
      key_permissions = [
        "create",
        "get",
        "delete",
        "list"
      ]

      secret_permissions = [
        "get",
        "delete",
        "list",
        "set"
      ]
    }
       access_policy {
    tenant_id = "${var.tenant_id}"
    object_id = "${var.object_id}"

    key_permissions = [
      "create",
      "get",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "list"
    ]
  }
  }