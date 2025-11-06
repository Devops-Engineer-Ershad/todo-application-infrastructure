module "rg-dev" {
  source = "../../modules/azurerm_resource_group"

  rgs = var.rg-main
}


module "stg-dev" {
  source = "../../modules/azurerm_storage_account"

  stgs = var.stg-main
  depends_on = [module.rg-dev]
}



module "vnet-dev" {
  source = "../../modules/azurerm_virtual_network"

  vnets = var.vnet-main
  depends_on = [module.rg-dev]
}

module "pip-dev" {
  source = "../../modules/azurerm_public_ip"

  public_ips = var.pip-main
  depends_on = [module.rg-dev]
}
module "nsg-dev" {
  source = "../../modules/azurerm_network_security_group"

  nsgs = var.nsg-main
  depends_on = [module.rg-dev]
}
module "nic-dev" {
  source = "../../modules/azurerm_network_interface"

  nics = var.nic-main
  depends_on = [module.rg-dev, module.pip-dev, module.vnet-dev]
}
module "nic_nsg_association-dev" {
  depends_on = [ module.nic-dev,module.nsg-dev ]
  nic_nsg_association = var.nic_nsg_association-main
  source = "../../modules/azurerm_nic_nsg_association"
}
module "vm-dev" {
  source = "../../modules/azurerm_linux_virtual_machine"

  vms = var.vms-main
  depends_on = [module.rg-dev, module.nic-dev]
}
