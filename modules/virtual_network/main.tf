# Create virtual network
# The resource names in the module get prefixed by module.<module-instance-name> when instantiated
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "${var.virtualNetwork}"
    address_space       = ["${var.address_space}"]
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    tags = "${var.Tags}"
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    count                = "${length(var.subnet_name)}"
    name                 = "${var.subnet_name[count.index]}"
    resource_group_name  = "${var.resource_group_name}"
    virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
    address_prefix       = cidrsubnet(var.address_space, var.new_bits, count.index+1)
}

# Create public IPs
resource "azurerm_public_ip" "my_vm_public_ip" {
    count                        = "${var.PublicIP != "" ? 1 : 0}"
    name                         = "${var.VM[count.index]}-${var.PublicIP}"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    allocation_method            = "Static"
    tags = "${var.Tags}"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    count               = "${length(var.subnet_name)}"
    name                = "${var.subnet_name[count.index]}-NSG"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    security_rule {
        name                       = "RDP"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "HTTPS"
        priority                   = 1010
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = "${var.Tags}"
}
resource "azurerm_subnet_network_security_group_association" "attachsubnet" {
  count                     = "${length(var.VM)}"
  subnet_id                 = "${azurerm_subnet.myterraformsubnet[count.index].id}"
  network_security_group_id = "${azurerm_subnet.myterraformsubnet[count.index].id}"
}
# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    count                     = "${length(var.VM)}"
    name                      = "${var.VM[count.index]}-NIC0${element(var.VM, count.index)}"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group_name}"

    ip_configuration {
        name                          = "${var.VM[count.index]}-NICconfig"
        subnet_id                     = "${azurerm_subnet.myterraformsubnet[count.index].id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${var.PublicIP != "" ? join ("", azurerm_public_ip.my_vm_public_ip.*.id) : "" }"
    }

    tags = "${var.Tags}"
}