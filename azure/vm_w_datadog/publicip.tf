resource "azurerm_public_ip" "tfPublicip" {
    name                         = "terraformPublicIP"
    location                     = "japaneast"
    resource_group_name          = "${azurerm_resource_group.tfRG.name}"
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}
