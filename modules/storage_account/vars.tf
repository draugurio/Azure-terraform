variable location {}

//variable storagename {}

variable resource_group_id {
  default = ""
  description = "Resource group ID"
}

variable resource_group_name {
  default = ""
  description = "Resource group name"
}
variable "StoragesName" {
  type = "list"
  default = ["storagelogcopy01","storagelogcopy02"]
}
variable Tags {}
