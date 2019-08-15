provider "azurerm" {
}
resource "azurerm_resource_group" "tfRG" {
        name = "terraformRG"
        location = "japaneast"

    tags = {
        environment = "Terraform Demo"
    }
}
