output "id" {
  value = "${azurerm_virtual_network.myterraformnetwork.id}"
}

output "name" {
  value = "${azurerm_virtual_network.myterraformnetwork.name}"
}

output "nic" {
  value = "${azurerm_network_interface.myterraformnic.*.id}"
}

output "vmip" {
  //value = "${var.PublicIP != "" ? 1 : [azurerm_public_ip.my_vm_public_ip.*.ip_address]}"
  //  value = "${var.PublicIP ? var.PublicIP : [azurerm_public_ip.my_vm_public_ip.*.ip_address]}"
  value = "${azurerm_public_ip.my_vm_public_ip.*.ip_address}"
}

output "subnet" {
  value = "${azurerm_subnet.myterraformsubnet.*.id}"
}