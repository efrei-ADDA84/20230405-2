# Retrieval of existing network information
data "azurerm_virtual_network" "tp4_vnet" {
  name                = "network-tp4"
  resource_group_name = var.resource_group
}

# Retrieval of existing subnet information
data "azurerm_subnet" "internal_subnet" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.tp4_vnet.name
  resource_group_name  = var.resource_group
}

# Creation of the network interface
resource "azurerm_network_interface" "devops_ni" {
  name                = "devops-ni"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.internal_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops_public_ip.id
  }
}

# Creation of the public IP address
resource "azurerm_public_ip" "devops_public_ip" {
  name                = "devops-public-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}