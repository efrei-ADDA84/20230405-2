# Key generation for SSH access
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Definition of the Azure Linux VM resource
resource "azurerm_linux_virtual_machine" "devops_vm" {
  # Virtual machine name
  name = "devops-${var.identifiant_efrei}"
  # Resource location
  location = var.location
  # Resource group to which the VM is associated
  resource_group_name = var.resource_group
  # ID of the network interface to attach to the VM
  network_interface_ids = [azurerm_network_interface.devops_ni.id]
  # VM size
  size = "Standard_D2s_v3"

  # Configuration of the OS disk
  os_disk {
    name                 = "osdiskk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Source image reference
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  # Administrator username
  admin_username = "devops"
  # Disable password authentication
  disable_password_authentication = true
  # Configuration of the administrator's SSH key
  admin_ssh_key {
    username   = "devops"
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  # Custom data to inject into the VM (Docker installation script)
  custom_data = base64encode(file("${path.module}/DOCKER.yml"))
}

resource "local_file" "private_key" {
  sensitive_content = tls_private_key.ssh_key.private_key_pem
  filename          = "C:/Users/magatte.ba/.ssh/devops_ssh_key.pem"
  file_permission   = "0600"
}

