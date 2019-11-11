variable "admin_username" {
  default = "azureuser"
  type    = "string"
}

variable "ssh_key" {
  default = "<YOUR_ROW_PUBKEY>"
  type    = "string"
}

variable "dd-apikey" {
  default = "<YOUR_DD_APIKEY>"
  type    = "string"
}
