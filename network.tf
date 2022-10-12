resource "azurerm_public_ip" "ip" {
  name                = "pip-we-d-cicd"
  resource_group_name = azurerm_resource_group.ci.name
  location            = azurerm_resource_group.ci.location
  allocation_method   = "Static"
}

resource "azurerm_virtual_network" "cicd" {
  name                = "vnet-we-d-cicd-network"
  resource_group_name = azurerm_resource_group.ci.name
  location            = azurerm_resource_group.ci.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "cicd" {
  name                 = "sbnt-cicd"
  resource_group_name  = azurerm_resource_group.ci.name
  virtual_network_name = azurerm_virtual_network.cicd.name
  address_prefixes     = ["10.254.1.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "nic-we-d-cicd"
  location            = azurerm_resource_group.ci.location
  resource_group_name = azurerm_resource_group.ci.name

  ip_configuration {
    name                          = "lvm-we-d-cicd-ip-conf"
    subnet_id                     = azurerm_subnet.cicd.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }
}
