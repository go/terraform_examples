locals {
  access_info = <<ACCESSINFO


Terraformed sample Azure configuration!!

To access virtual machine, plase use below access information.

PublicIP: ${azurerm_public_ip.tfPublicip.ip_address}
Username: ${var.admin_username}
ACCESSINFO
}

output "access_info" {
  value = "${local.access_info}"
}
