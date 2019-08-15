resource "azurerm_virtual_network" "tfNetwork" {
    name                = "terraformVnet"
    address_space       = ["192.168.10.0/24"]
    location            = "japaneast"
    resource_group_name = "${azurerm_resource_group.tfRG.name}"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_subnet" "tfSubnet" {
    name                 = "terraformSubnet"
    resource_group_name  = "${azurerm_resource_group.tfRG.name}"
    virtual_network_name = "${azurerm_virtual_network.tfNetwork.name}"
    address_prefix       = "192.168.10.0/27"
}

resource "azurerm_network_security_group" "tfNsg" {
    name                = "terraformNetworkSecurityGroup"
    location            = "japaneast"
    resource_group_name = "${azurerm_resource_group.tfRG.name}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "${local.workstation-external-cidr}"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "WEB"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface" "tfNic" {
    name                = "terraformNIC"
    location            = "japaneast"
    resource_group_name = "${azurerm_resource_group.tfRG.name}"
    network_security_group_id = "${azurerm_network_security_group.tfNsg.id}"

    ip_configuration {
        name                          = "terraformNicConfiguration"
        subnet_id                     = "${azurerm_subnet.tfSubnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.tfPublicip.id}"
    }

    tags = {
        environment = "Terraform Demo"
    }
}
