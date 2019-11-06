resource "azurerm_automation_module" "Module" {
  name                    = "${var.ModuleName}"
  resource_group_name     = "${var.RGName}"
  automation_account_name = "${var.AutomationName}"

  module_link {
    uri = "${var.modulelink}"
  }
}