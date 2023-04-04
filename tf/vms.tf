resource "azurerm_public_ip" "onpremise-vm01-pip" {
  name                = "onpremise-vm01-pip01"
  location            = azurerm_resource_group.onpremise-rg.location
  resource_group_name = azurerm_resource_group.onpremise-rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "onpremise-vm01-nic" {
  name                = "onpremise-vm01-ni01"
  location            = azurerm_resource_group.onpremise-rg.location
  resource_group_name = azurerm_resource_group.onpremise-rg.name

  ip_configuration {
    name                          = "ipConfig1"
    subnet_id                     = azurerm_subnet.onpremise-default-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.onpremise-vm01-pip.id
  }
}

resource "azurerm_network_security_group" "onpremise_nsg" {
  name                = "onpremise-nsg"
  location            = azurerm_resource_group.onpremise-rg.location
  resource_group_name = azurerm_resource_group.onpremise-rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "onpremise_nsg-nic-01" {
  network_interface_id      = azurerm_network_interface.onpremise-vm01-nic.id
  network_security_group_id = azurerm_network_security_group.onpremise_nsg.id
}

resource "azurerm_windows_virtual_machine" "onpremise-vm01" {
  name                            = "DC01-VM"
  resource_group_name             = azurerm_resource_group.onpremise-rg.name
  location                        = azurerm_resource_group.onpremise-rg.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  network_interface_ids           = [azurerm_network_interface.onpremise-vm01-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "dc01-vm-od01"
  }

  source_image_reference {
    publisher = var.vm_os_publisher
    offer     = var.vm_os_offer
    sku       = var.vm_os_sku
    version   = var.vm_os_version
  }
}

resource "azurerm_network_interface" "spoke01-vm01-nic" {
  name                = "spoke01-vm01-ni01"
  location            = azurerm_resource_group.spoke01-rg.location
  resource_group_name = azurerm_resource_group.spoke01-rg.name

  ip_configuration {
    name                          = "ipConfig2"
    subnet_id                     = azurerm_subnet.spoke01-default-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "spoke01-vm01" {
  name                            = "DNS-VM"
  resource_group_name             = azurerm_resource_group.spoke01-rg.name
  location                        = azurerm_resource_group.spoke01-rg.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  network_interface_ids           = [azurerm_network_interface.spoke01-vm01-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "dns-vm-od01"
  }

  source_image_reference {
    publisher = var.vm_os_publisher
    offer     = var.vm_os_offer
    sku       = var.vm_os_sku
    version   = var.vm_os_version
  }

}
resource "azurerm_network_interface" "spoke02-vm01-nic" {
  name                = "spoke02-vm01-ni01"
  location            = azurerm_resource_group.spoke02-rg.location
  resource_group_name = azurerm_resource_group.spoke02-rg.name

  ip_configuration {
    name                          = "ipConfig3"
    subnet_id                     = azurerm_subnet.spoke02-default-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "spoke02-vm01" {
  name                            = "SPOKE02-VM"
  resource_group_name             = azurerm_resource_group.spoke02-rg.name
  location                        = azurerm_resource_group.spoke02-rg.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  network_interface_ids           = [azurerm_network_interface.spoke02-vm01-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "spoke02-vm-od01"
  }

  source_image_reference {
    publisher = var.vm_os_publisher
    offer     = var.vm_os_offer
    sku       = var.vm_os_sku
    version   = var.vm_os_version
  }
}

resource "azurerm_network_interface" "spoke03-vm01-nic" {
  name                = "spoke03-vm01-ni01"
  location            = azurerm_resource_group.spoke03-rg.location
  resource_group_name = azurerm_resource_group.spoke03-rg.name

  ip_configuration {
    name                          = "ipConfig4"
    subnet_id                     = azurerm_subnet.spoke03-default-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "spoke03-vm01" {
  name                            = "SPOKE03-VM"
  resource_group_name             = azurerm_resource_group.spoke03-rg.name
  location                        = azurerm_resource_group.spoke03-rg.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  network_interface_ids           = [azurerm_network_interface.spoke03-vm01-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "spoke03-vm-od01"
  }

  source_image_reference {
    publisher = var.vm_os_publisher
    offer     = var.vm_os_offer
    sku       = var.vm_os_sku
    version   = var.vm_os_version
  }

}
