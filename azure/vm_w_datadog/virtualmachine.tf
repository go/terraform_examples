resource "azurerm_virtual_machine" "tfVm" {
    name                  = "terraformVM"
    location              = "japaneast"
    resource_group_name   = "${azurerm_resource_group.tfRG.name}"
    network_interface_ids = ["${azurerm_network_interface.tfNic.id}"]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "terraformOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "terraformVm"
        admin_username = "${var.admin_username}"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "${var.ssh_key}"
        }
    }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.tfStorageaccount.primary_blob_endpoint}"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_virtual_machine_extension" "dd-agent" {
  name                       = "DatadogAgent"
  location                   = "${azurerm_resource_group.tfRG.location}"
  resource_group_name        = "${azurerm_resource_group.tfRG.name}"
  virtual_machine_name       = "${azurerm_virtual_machine.tfVm.name}"
  publisher                  = "Datadog.Agent"
  type                       = "DatadogLinuxAgent"
  type_handler_version       = "0.7"
  auto_upgrade_minor_version = "true"

  settings = <<SETTINGS
    {
      "api_key": "${var.dd-apikey}"
    }
SETTINGS
}
