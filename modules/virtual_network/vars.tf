variable resource_group_name {
  default = ""
  description = "Resource group name"
}

variable "Prefix" {
  description = "core"
  default     = ""
}
variable "PublicIP" {
  description = ""
  default     = ""
}
variable "subnet_name" {
  description = ""
  type        = "list"
  default     = ["subnet1"]
}
variable "new_bits" {
  description = ""
  type        = "string"
  default     = "4"
}
variable "address_space" {
  description = ""
  type        = "string"
  default     = "10.0.1.0/24"
}
variable "VM" {}
variable "location" {}
variable "Tags" {}
variable "virtualNetwork" {
  default = "core-vnet1"
}
variable "boot_diagnostics" {
  default = false
}
