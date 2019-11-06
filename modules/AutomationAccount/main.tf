resource "azurerm_automation_account" "automation" {
  name                = "${var.AutomationName}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku_name = "Basic"

  tags = "${var.Tags}"
}
resource "azurerm_automation_module" "AAModules" {
  count                   = "${length(var.ModulesName)}"
  name                    = "${element(var.ModulesName, count.index)}"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.automation.name}"

  module_link {
    uri ="${element(var.ModulesUri, count.index)}"
  }
    provisioner "local-exec" {
    command = "sleep 5"
  }
}