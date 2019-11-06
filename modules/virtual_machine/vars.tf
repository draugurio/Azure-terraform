variable resource_group_name {
  default = ""
  description = "Resource group name"
}

variable "Prefix" {
  description = "core"
  default     = ""
}
variable "admin_username" {
  description = ""
  default     = "Administrador"
}
variable "VM" {}
variable "Tags" {}
variable "key_vault_id" {}
variable "location" {}
variable "network_interface_ids" {}
variable "boot_diagnostics" {
  default = false
}
