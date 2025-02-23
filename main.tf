terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "david-x" {
  name     = "David-TerraformX"
  location = "West Europe"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "david-vn" {
  name                = "David-networkx"
  resource_group_name = azurerm_resource_group.david-x.name
  location            = azurerm_resource_group.david-x.location
  address_space       = ["10.124.0.0/16"]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "david-subnet" {
  name                 = "david-subnetx"
  resource_group_name  = azurerm_resource_group.david-x.name
  virtual_network_name = azurerm_virtual_network.david-vn.name
  address_prefixes     = ["10.124.1.0/24"]
}

resource "azurerm_network_security_group" "david-sgroup" {
  name                = "David-Sgroupx"
  location            = azurerm_resource_group.david-x.location
  resource_group_name = azurerm_resource_group.david-x.name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow_ssh"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.david-sgroup.name
  resource_group_name         = azurerm_resource_group.david-x.name
}

resource "azurerm_subnet_network_security_group_association" "david-ass" {
  subnet_id                 = azurerm_subnet.david-subnet.id
  network_security_group_id = azurerm_network_security_group.david-sgroup.id
}

resource "azurerm_public_ip" "david-ip" {
  name                = "david-ipx"
  location            = azurerm_resource_group.david-x.location
  resource_group_name = azurerm_resource_group.david-x.name
  allocation_method   = "Static"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "david-nic" {
  name                      = "david-nicx"
  location                  = azurerm_resource_group.david-x.location
  resource_group_name       = azurerm_resource_group.david-x.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.david-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.david-ip.id
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_linux_virtual_machine" "david-vm" {
  name                = "david-vmx"
  location            = azurerm_resource_group.david-x.location
  resource_group_name = azurerm_resource_group.david-x.name
  size                = "Standard_B1s"
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/desktop.pub")
  }

  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.david-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "16.04-LTS"
  version   = "16.04.202009080"
}

}

output "public_ip" {
  value = azurerm_public_ip.david-ip.ip_address
}
