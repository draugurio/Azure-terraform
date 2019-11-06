# Create virtual machine
 resource "random_password" "password" {
    count        = "${length(var.VM)}"
    length            = 16
    special           = true 
    number            = true
    override_special  = "%_@"
  }
  resource "azurerm_key_vault_secret" "VMSecretCreation" {
    count        = "${length(var.VM)}"
    name         = "${var.VM[count.index]}-${var.admin_username}"
    value        = "${random_password.password[count.index].result}"
    key_vault_id = "${var.key_vault_id}"
    tags         = "${var.Tags}"
 }


resource "azurerm_virtual_machine" "WindowsVM"{
    count                 = "${length(var.VM)}"
    name =                  "${var.VM[count.index]}"
    resource_group_name =   "${var.resource_group_name}"
    location =              "${var.location}"
    network_interface_ids =  "${var.network_interface_ids}"
    vm_size =               "Standard_DS2_v2"
    tags                    = "${var.Tags}"
      storage_image_reference {
            publisher = "MicrosoftWindowsServer"
            offer     = "WindowsServer"
            sku       = "2016-Datacenter"
            version   = "latest"
      }
      storage_os_disk{
          name              = "osdisk-${var.VM[count.index]}"
          create_option     = "FromImage"
          caching           = "ReadWrite"
          managed_disk_type = "Standard_LRS"
          disk_size_gb      = "40"
      }
      os_profile{
        computer_name   = "Hostname-${var.VM[count.index]}"
        admin_username = "${var.admin_username}"
        admin_password = "${azurerm_key_vault_secret.VMSecretCreation[count.index].value}"
      }
        os_profile_windows_config {
         provision_vm_agent        = true
         enable_automatic_upgrades = true
      }
      /*boot_diagnostics {
        enabled     = "${var.boot_diagnostics}"
        storage_uri = "${var.BootDiagnostic == "true" ? join(",", azurerm_storage_account.StorageAccount.*.primary_blob_endpoint) : "" }"
      }*/
  }




/*    Linux VM

resource "azurerm_virtual_machine" "myterraformvm" {
    name                  = "${var.resource_group_name}vm"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group_name}"
    network_interface_ids = ["${var.vnetwork_interface_id}"]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "${var.resource_group_name}-OSDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "myvm"
        admin_username = "${var.admin_username}"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/${var.admin_username}/.ssh/authorized_keys"
            key_data = "${file(var.sshkey)}"
        }
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = "${var.blob_storage_url}"
    }

    tags {
        environment = "Terraform Demo"
    }
}
*/