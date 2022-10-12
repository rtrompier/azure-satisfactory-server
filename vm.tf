data "template_file" "linux_script" {
  template = file("./scripts/init.sh")
  vars = {
    disk_lun = var.disk_lun
  }
}

resource "azurerm_linux_virtual_machine" "cicd" {
  count                           = var.deploy_vm ? 1 : 0
  name                            = "lvm-we-d-cicd"
  location                        = azurerm_resource_group.ci.location
  resource_group_name             = azurerm_resource_group.ci.name
  size                            = "Standard_D4as_v5"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDqyOVAUp2Fz3sAgdxKQLuOUYpnqaPle/54x9fpVA/g11UydtQvzufTE2DeIOOYkkSRnDtmkK3WO2OmE65rSwJ2c/jKhvzRcRwEgg+WzBSAlFKkkJDGFZLxcZR52My+GSllZvqkJKz4eN6p0xw6m9MQQhiLbDduNUTGGHGMFloOFDviFdIXpD49qqY5aiYn1cnhzHVGc7Qei23quVoXjVF20t07X8BDfIVCrvZs4JwkPpGqCo5TR60108TffFCZ5QpmzMu/RnRxA6QQyTw+4RuZhIH99p9Z88lc66WtfoB2AR9Xe+NpMqk6f3OlWw/JePlhNlD96Cp0ne1F2ThO/rxGn0GDmSAdWr6MmiBmADdS599KK9Ng16mUMY9y4ykCCp3hEK/pcpRzJpLQCrVW9L6SKKVj199wa5raSFOma9xTlYXusPr/NZE+qrZt5OiflD2ps5zTBpINQOiVSSVCwN/Idy/ASs1gnq/wNM8i4Jl0D8H8pijBWn1WJTyktmTToj/HtfgKWKagBd0iT5iLHLg39y2vPictI9HBgJ5VJ5R+DmdeUoWfjKorZR/RwxxUdBav8T82QXeIR7AvBYuW5wND7HWZ5vsSSQNtQ2GVZH5R8py6m4E7Ycwz1gESGVCqU0oWpSnv83HTeYYNOYvm7bwdDiWJpmRxQS0HwfQSLcWjw== rtrm@mac-0522"
  }

  custom_data = base64encode(data.template_file.linux_script.rendered)

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                      = "lvm-we-d-cicd-disk"
    caching                   = "ReadWrite"
    storage_account_type      = "StandardSSD_LRS"
    write_accelerator_enabled = false
  }

}

# resource "azurerm_managed_disk" "disk" {
#   name                 = "lvm-we-d-cicd-datadisk"
#   location             = azurerm_resource_group.ci.location
#   resource_group_name  = azurerm_resource_group.ci.name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = 10
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachement" {
#   count              = var.deploy_vm ? 1 : 0
#   managed_disk_id    = azurerm_managed_disk.disk.id
#   virtual_machine_id = azurerm_linux_virtual_machine.cicd[0].id
#   lun                = var.disk_lun
#   caching            = "ReadWrite"
# }
