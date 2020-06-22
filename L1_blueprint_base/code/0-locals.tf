locals {
  unique_Logs     = substr(sha1(azurerm_resource_group.Logs-rg.id), 0, 3)
  unique_Keyvault = substr(sha1(azurerm_resource_group.Keyvault-rg.id), 0, 8)
  prefix          = "${var.env}-${var.group}"
  l0_prefix       = "${var.env}-${var.group}_${var.project}"
}
