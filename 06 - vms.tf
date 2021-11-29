# ##########################
# #                        #
# #         Main Vms       #  
# #                        #
# ##########################


# ##########################
# #                        #
# #       VM01 DC          #  
# #                        #
# ##########################

#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-01-dc-server-prd
 resource "azurerm_virtual_machine" "vm-01-dc-dns" {
    # id                           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-01-dc-server-prd"
    location                     = "brazilsouth"
    name                         = "vm-01-dc-server-prd"
    network_interface_ids        = [
        azurerm_network_interface.inet-01-vm-01-dc-dns.id,
    ]
    primary_network_interface_id = azurerm_network_interface.inet-01-vm-01-dc-dns.id
    resource_group_name          = "rg-br-server-prd"
    tags                         = {
        "environment" = "prod"
        "project"     = "server"        
    }
    vm_size                      = "Standard_B2s"
    zones                        = []

    boot_diagnostics {
        enabled     = true
        storage_uri = "https://storagekserver.blob.core.windows.net/"
    }

    storage_os_disk {
        caching                   = "ReadWrite"
        create_option             = "Attach"
        disk_size_gb              = 127
        managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm01dcserverprd-osdisk-20210414-202359"
        managed_disk_type         = "Standard_LRS"
        name                      = "vm01dcserverprd-osdisk-20210414-202359"
        os_type                   = "Windows"
        write_accelerator_enabled = false
    }

    timeouts {}
 }

# #Criação da maquina virtual domain control
# resource "azurerm_virtual_machine" "vm-01-dc-dns" {
#   name                = "vm-01-dc-dns"  
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   network_interface_ids = [
#     azurerm_network_interface.inet-01-vm-01-dc-dns.id
#   ]
#   vm_size                = "Standard_D2as_v4" # Standard_D2as_v4 Standard_D4as_v4
#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   # delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   # delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }
  
#   storage_os_disk {
#     name              = "osdisk-vm-01-dc-dns"
#     caching           = "ReadWrite"
#     #disk_size_gb      = 30
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = "DomainDns"
#     admin_username = "admindomain"
#     admin_password = "Pulsepulse@2021"
#   }

#   os_profile_windows_config {
#     provision_vm_agent = true  
#   }

#   boot_diagnostics {
#          enabled = true
#          storage_uri = ""
#   }

#   tags     = {
#       "environment" = "prod"
#       "project"  = "server"
#   }
# }  

# ##########################
# #                        #
# #       VM02 CB-LIC      #  
# #                        #
# ##########################
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/virtualMachines/vm-02-cb-lic-server
  resource "azurerm_virtual_machine" "vm-02-cb-lic" {
    #id                           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/virtualMachines/vm-02-cb-lic-server"
    location                     = "brazilsouth"
    name                         = "vm-02-cb-lic-server"
    network_interface_ids        = [
        azurerm_network_interface.inet-01-vm-02-cb-lic.id,
    ]
    primary_network_interface_id = azurerm_network_interface.inet-01-vm-02-cb-lic.id
    resource_group_name          = "RG-BR-server-PRD"
    tags                         = {
        "environment" = "prod"
        "project"     = "server"
        "Start"       = "7am"
       "Stop"        = "8pm"                 
    }
    vm_size                      = "Standard_D2as_v4"
    zones                        = []

    storage_os_disk {
        caching                   = "ReadWrite"
        create_option             = "Attach"
        disk_size_gb              = 127
        managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm02cblicserver-osdisk-20210414-202713"
        managed_disk_type         = "Standard_LRS"
        name                      = "vm02cblicserver-osdisk-20210414-202713"
        os_type                   = "Windows"
        write_accelerator_enabled = false
    }

    boot_diagnostics {
        enabled     = true
        storage_uri = "https://storagekserver.blob.core.windows.net/"
    }

    timeouts {}
  }

# #Criação da maquina virtual do Connection Broker e Licenciamento linux
# resource "azurerm_virtual_machine" "vm-02-cb-lic" {
#   name                = "vm-02-cb-lic"  
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   network_interface_ids = [
#     azurerm_network_interface.inet-01-vm-02-cb-lic.id
#   ]
#   vm_size                = "Standard_D2as_v4" # Standard_D2as_v4
#   #Uncomment this line to delete the OS disk automatically when deleting the VM
#   #delete_os_disk_on_termination = true

#   #Uncomment this line to delete the data disks automatically when deleting the VM
#   #delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }
  
#   storage_os_disk {
#     name              = "osdisk-vm-02-cb-lic"
#     caching           = "ReadWrite"
#     #disk_size_gb      = 128
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = "BrokerLic"
#     admin_username = "adminbroker"
#     admin_password = "Pulsepulse@2021"
#   }

#   #if windows image uncomment
#   os_profile_windows_config {
#     provision_vm_agent = true
#   }
  
#   boot_diagnostics {
#          enabled = true
#          storage_uri = ""
#   }

#   tags     = {
#     "environment" = "prod"
#     "project"  = "server"
#   }
# }  


# ##########################
# #                        #
# #       VM03 server     #  
# #                        #
# ##########################

# #Criação da maquina virtual server 01 linux
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-03-server-01-prd
resource "azurerm_virtual_machine" "vm-03-server-01-prd" {
 #id                           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-03-server-01-prd"
    location                     = "brazilsouth"
    name                         = "vm-03-server-01-prd"
    network_interface_ids        = [
        azurerm_network_interface.inet-01-vm-03-server-01-prd.id,
    ]
    primary_network_interface_id = azurerm_network_interface.inet-01-vm-03-server-01-prd.id
    resource_group_name          = "rg-br-server-prd"
    tags                         = {
        "environment" = "prod"
        "project"     = "server"
    }
    vm_size                      = "Standard_F4s_v2"
    zones                        = []

    boot_diagnostics {
        enabled = true
        storage_uri = "https://storagekserver.blob.core.windows.net/"
    }

    storage_data_disk {
        caching                   = "ReadWrite"
        create_option             = "Attach"
        disk_size_gb              = 128
        lun                       = 2
        managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm03server01prd-datadisk-002-20210414-204259"
        managed_disk_type         = "Standard_LRS"
        name                      = "vm03server01prd-datadisk-002-20210414-204259"
        write_accelerator_enabled = false
    }

    storage_os_disk {
        caching                   = "ReadWrite"
        create_option             = "Attach"
        disk_size_gb              = 127
        managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm03server01prd-osdisk-20210414-204259"
        managed_disk_type         = "Standard_LRS"
        name                      = "vm03server01prd-osdisk-20210414-204259"
        os_type                   = "Windows"
        write_accelerator_enabled = false
    }

    timeouts {}
}

# resource "azurerm_virtual_machine" "vm-03-server-01" {
#   # name                = "vm-03-server-01"  
#   # resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#   # location            = azurerm_resource_group.rg-br-server-prd.location 
#   # network_interface_ids = [
#   #   azurerm_network_interface.inet-01-vm-03-server-01.id
#   # ]
#   # vm_size                = "Standard_F4s_v2" # Standard_F8s_v2

#   # # Uncomment this line to delete the OS disk automatically when deleting the VM
#   # # delete_os_disk_on_termination = true

#   # # Uncomment this line to delete the data disks automatically when deleting the VM
#   # # delete_data_disks_on_termination = true

#   # storage_image_reference {
#   #   publisher = "MicrosoftWindowsServer"
#   #   offer     = "WindowsServer"
#   #   sku       = "2019-Datacenter"
#   #   version   = "latest"
#   # }

#   # storage_os_disk {
#   #   name              = "osdisk-vm-03-server-01"
#   #   caching           = "ReadWrite"
#   #   #disk_size_gb      = 32
#   #   create_option     = "FromImage"
#   #   managed_disk_type = "Standard_LRS"
#   # }

#   # os_profile {
#   #   computer_name  = "server1"
#   #   admin_username = "adminserver01"
#   #   admin_password = "Pulsepulse@2021"
#   # }

#   # os_profile_windows_config {
#   #   provision_vm_agent = true
#   # }
  
#   # boot_diagnostics {
#   #        enabled = true
#   #        storage_uri = ""
#   # }

#   # tags     = {
#   #     "environment" = "prod"
#   #     "project"  = "server"
#   # }
#     #id                    = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-03-server-01"
#     location              = "brazilsouth"
#     name                  = "vm-03-server-01"
#     network_interface_ids = [
#         "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/inet-01-vm-03-server-01",
#     ]
#     resource_group_name   = "rg-br-server-prd"
#     tags                  = {
#         "environment" = "prod"
#         "project"     = "server"
#     }
#     vm_size               = "Standard_F4s_v2"
#     zones                 = []

#     os_profile {
#         admin_username = "adminserver01"
#         computer_name  = "server1"
#     }

#     os_profile_windows_config {
#         enable_automatic_upgrades = false
#         provision_vm_agent        = true
#     }

#     storage_data_disk {
#         caching                   = "ReadWrite"
#         create_option             = "Attach"
#         disk_size_gb              = 128
#         lun                       = 2
#         managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/disk-01-vm-03-server-01"
#         managed_disk_type         = "Standard_LRS"
#         name                      = "disk-01-vm-03-server-01"
#         write_accelerator_enabled = false
#     }

#     storage_image_reference {
#         offer     = "WindowsServer"
#         publisher = "MicrosoftWindowsServer"
#         sku       = "2019-Datacenter"
#         version   = "latest"
#     }

#     storage_os_disk {
#         caching                   = "ReadWrite"
#         create_option             = "FromImage"
#         disk_size_gb              = 127
#         managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/disks/osdisk-vm-03-server-01"
#         managed_disk_type         = "Standard_LRS"
#         name                      = "osdisk-vm-03-server-01"
#         os_type                   = "Windows"
#         write_accelerator_enabled = false
#     }

#     timeouts {}
# } 

# ##########################
# #                        #
# #       VM04 WA-GW       #
# #                        #
# ##########################

# #Criação da maquina virtual do webaccess gateway
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/virtualMachines/vm-04-wa-gw-server
 resource "azurerm_virtual_machine" "vm-04-wa-gw-server" {
    #id                           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/virtualMachines/vm-04-wa-gw-server"
    location                     = "brazilsouth"
    name                         = "vm-04-wa-gw-server"
    network_interface_ids        = [
        azurerm_network_interface.inet-01-vm-04-wa-gw-server.id,
    ]
    primary_network_interface_id = azurerm_network_interface.inet-01-vm-04-wa-gw-server.id
    resource_group_name          = "RG-BR-server-PRD"
    tags                         = {
        "environment" = "prod"
        "project"     = "server"
        "Start"       = "7am"
        "Stop"        = "8pm"         
    }
    boot_diagnostics {
        enabled     = true
        storage_uri = "https://storagekserver.blob.core.windows.net/"
    }

    vm_size                      = "Standard_D2as_v4"
    zones                        = []

    storage_os_disk {
        caching                   = "ReadWrite"
        create_option             = "Attach"
        disk_size_gb              = 127
        managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm04wagwserver-osdisk-20210414-203056"
        managed_disk_type         = "Standard_LRS"
        name                      = "vm04wagwserver-osdisk-20210414-203056"
        os_type                   = "Windows"
        write_accelerator_enabled = false
    }

    timeouts {}
 }

# resource "azurerm_virtual_machine" "vm-04-wa-gw" {
#   name                = "vm-04-wa-gw"  
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   network_interface_ids = [
#     azurerm_network_interface.inet-01-vm-04-wa-gw.id
#   ]
#   vm_size                = "Standard_D2as_v4" #Standard_F4s_v2

#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   # delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   # delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }

#   storage_os_disk {
#      name              = "osdisk-vm-04-wa-gw"
#      caching           = "ReadWrite"
#   #   #disk_size_gb      = 32
#      create_option     = "FromImage"
#      managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = "WebGateway"
#     admin_username = "adminweb"
#     admin_password = "Pulsepulse@2021"
#   }

#   os_profile_windows_config {
#     provision_vm_agent = true
#   }
  
#   boot_diagnostics {
#          enabled = true
#          storage_uri = ""
#   }

#   tags     = {
#       "environment" = "prod"
#       "project"  = "server"
#   }
# }  

# ##########################
# #                        #
# #      VM05  Wireguard   #
# #                        #
# ##########################

# #Criação da maquina virtual wireguard linux
# resource "azurerm_linux_virtual_machine" "vm-05-wireguard" {
#   name                = "vm-05-wireguard"
#   computer_name       = "vm-05-wireguard"
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   size                = "Standard_B4ms" # from Standard_F2 to Standard_F4s_v2 Standard_D4s_v4 Standard_B4ms
#   admin_username      = "rootvpn"
#   network_interface_ids = [
#     azurerm_network_interface.inet-01-vm-wireguard.id,
#     azurerm_network_interface.inet-02-vm-wireguard.id,
#     azurerm_network_interface.inet-03-vm-wireguard.id
#   ]

#   admin_ssh_key {
#     username   = "rootvpn"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#     #disk_size_gb         = 30
#     name                 = "osdisk-vm-05-wireguard"
#   }

#   source_image_reference {
#     publisher = "Debian"
#     offer     = "debian-10"
#     sku       = "10"
#     version   = "latest"
#   }

#   provision_vm_agent = true

#   tags     = {
#       "environment" = "prod"
#       "project"  = "server"
#   }
# }


# ##########################
# #                        #
# #       VM06 server     #  
# #                        #
# ##########################

# #Criação da maquina virtual server 01 linux
 resource "azurerm_virtual_machine" "vm-06-server-02-prd" {
    # id                           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-06-server-02-prd"
    location                     = "brazilsouth"
    name                         = "vm-06-server-02-prd"
    network_interface_ids        = [
        azurerm_network_interface.inet-01-vm-06-server-02-prd.id,
    ]
    primary_network_interface_id = azurerm_network_interface.inet-01-vm-06-server-02-prd.id
    resource_group_name          = "rg-br-server-prd"
    tags                         = {
        "environment" = "prod"
        "project"     = "server"
    }
    vm_size                      = "Standard_F4s_v2"
    zones                        = []
    boot_diagnostics {
        enabled     = true
        storage_uri = "https://storagekserver.blob.core.windows.net/"
    }

    storage_data_disk {
        caching                   = "ReadWrite"
        create_option             = "Attach"
        disk_size_gb              = 32
        lun                       = 2
        managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm06server02prd-datadisk-002-20210414-204123"
        managed_disk_type         = "Standard_LRS"
        name                      = "vm06server02prd-datadisk-002-20210414-204123"
        write_accelerator_enabled = false
    }

    storage_os_disk {
        caching                   = "ReadWrite"
        create_option             = "Attach"
        disk_size_gb              = 127
        managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm06server02prd-osdisk-20210414-204123"
        managed_disk_type         = "Standard_LRS"
        name                      = "vm06server02prd-osdisk-20210414-204123"
        os_type                   = "Windows"
        write_accelerator_enabled = false
    }

    timeouts {}
 }
# resource "azurerm_virtual_machine" "vm-06-server-02" {
#   # name                = "vm-06-server-02"  
#   # resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#   # location            = azurerm_resource_group.rg-br-server-prd.location 
#   # network_interface_ids = [
#   #   azurerm_network_interface.inet-01-vm-06-server-02.id
#   # ]
#   # vm_size                = "Standard_F4s_v2" # Standard_F8s_v2
#   # boot_diagnostics {
#   #        enabled = true
#   #        storage_uri = ""
#   # }
#   # # Uncomment this line to delete the OS disk automatically when deleting the VM
#   # # delete_os_disk_on_termination = true

#   # # Uncomment this line to delete the data disks automatically when deleting the VM
#   # # delete_data_disks_on_termination = true

#   # storage_image_reference {
#   #   publisher = "MicrosoftWindowsServer"
#   #   offer     = "WindowsServer"
#   #   sku       = "2019-Datacenter"
#   #   version   = "latest"
#   # }

#   # storage_os_disk {
#   #   name              = "osdisk-vm-06-server-02"
#   #   caching           = "ReadWrite"
#   #   #disk_size_gb      = 32
#   #   create_option     = "FromImage"
#   #   managed_disk_type = "Standard_LRS"
#   # }

#   # os_profile {
#   #   computer_name  = "server2"
#   #   admin_username = "adminserver02"
#   #   admin_password = "Pulsepulse@2021"
#   # }

#   # os_profile_windows_config {
#   #   provision_vm_agent = true
#   # }

#   # tags     = {
#   #     "environment" = "prod"
#   #     "project"  = "server"
#   # }
#     #id                           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/virtualMachines/vm-06-server-02"
#     location                     = "brazilsouth"
#     name                         = "vm-06-server-02"
#     network_interface_ids        = [
#         "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/inet-01-vm-06-server-02",
#     ]
#     primary_network_interface_id = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/inet-01-vm-06-server-02"
#     resource_group_name          = "RG-BR-server-PRD"
#     tags                         = {
#         "environment" = "prod"
#         "project"     = "server"
#     }
#     vm_size                      = "Standard_F4s_v2"
#     zones                        = []

#     boot_diagnostics {
#         enabled = true
#         storage_uri = ""
#     }

#     os_profile {
#         admin_username = "adminserver02"
#         computer_name  = "server2"
#     }

#     os_profile_windows_config {
#         enable_automatic_upgrades = false
#         provision_vm_agent        = true
#     }

#     storage_data_disk {
#         caching                   = "ReadWrite"
#         create_option             = "Attach"
#         disk_size_gb              = 32
#         lun                       = 2
#         managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/disk-01-vm-06-server-02"
#         managed_disk_type         = "Standard_LRS"
#         name                      = "disk-01-vm-06-server-02"
#         write_accelerator_enabled = false
#     }

#     storage_image_reference {
#         offer     = "WindowsServer"
#         publisher = "MicrosoftWindowsServer"
#         sku       = "2019-Datacenter"
#         version   = "latest"
#     }

#     storage_os_disk {
#         caching                   = "ReadWrite"
#         create_option             = "FromImage"
#         disk_size_gb              = 127
#         managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/disks/osdisk-vm-06-server-02"
#         managed_disk_type         = "Standard_LRS"
#         name                      = "osdisk-vm-06-server-02"
#         os_type                   = "Windows"
#         write_accelerator_enabled = false
#     }

#     timeouts {}
# } 


# ##########################
# #                        #
# #      VM05  Wireguard   #
# #                        #
# ##########################

#Criação da maquina virtual wireguard linux
resource "azurerm_linux_virtual_machine" "vm-01-wireguard-gw-hub" {
  name                = "vm-01-wireguard-gw-hub"
  computer_name       = "vm-01-wireguard-gw-hub"
  resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
  location            = azurerm_resource_group.rg-br-infra-prod.location
  size                = "Standard_B1ms" # from Standard_F2 to Standard_F4s_v2 Standard_D4s_v4 Standard_B4ms
  admin_username      = "rootvpn"
  network_interface_ids = [
    azurerm_network_interface.inet-01-vm-01-wireguard-gw-hub.id,
  ]

  admin_ssh_key {
    username   = "rootvpn"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    #disk_size_gb         = 30
    name                 = "osdisk-vm-01-wireguard-gw-hub"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }

  provision_vm_agent = true

  tags     = {
      "environment" = "prod"      
  }
}


#Criação da maquina virtual wireguard linux
# resource "azurerm_linux_virtual_machine" "vm-01-linux-server" {
#   name                = "vm-01-linux-server"
#   computer_name       = "vm-01-linux-server"
#   resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
#   location            = azurerm_resource_group.rg-br-infra-prod.location
#   size                = "Standard_B1ms" # from Standard_F2 to Standard_F4s_v2 Standard_D4s_v4 Standard_B4ms
#   admin_username      = "rootvpn"
#   network_interface_ids = [
#     azurerm_network_interface.inet-01-vm-01-linux-server.id,
#   ]

#   admin_ssh_key {
#     username   = "rootvpn"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#     #disk_size_gb         = 30
#     name                 = "osdisk-vm-01-linux-server"
#   }

#   source_image_reference {
#     publisher = "Debian"
#     offer     = "debian-10"
#     sku       = "10"
#     version   = "latest"
#   }

#   provision_vm_agent = true

#   tags     = {
#       "environment" = "prod"      
#   }
# }

##########################
#                        #
#       VM03 server     #  
#                        #
##########################

#Criação da maquina virtual server 01 linux
# resource "azurerm_virtual_machine" "vm-03-serverr-01" {
#   name                = "vm-03-serverr-01"  
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#   location            = azurerm_resource_group.rg-br-server-prd.location 
#   network_interface_ids = [
#     azurerm_network_interface.inet-01-vm-03-serverr-01.id
#   ]
#   vm_size                = "Standard_F4s_v2" # Standard_F8s_v2

#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   # delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   # delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name              = "osdisk-vm-03-serverr-01"
#     caching           = "ReadWrite"
#     #disk_size_gb      = 32
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = "server01"
#     admin_username = "adminserver01"
#     admin_password = "Pulsepulse@2021"
#   }

#   os_profile_windows_config {
#     provision_vm_agent = true
#   }
  
#   boot_diagnostics {
#       enabled     = true
#       storage_uri = "https://storagekserver.blob.core.windows.net/"
#   }

#   tags     = {
#       "environment" = "prod"
#       "project"  = "server"
#   }
# }

##########################
#                        #
#       VM03 server     #  
#                        #
##########################

#Criação da maquina virtual server 01 linux
resource "azurerm_virtual_machine" "vm-07-server-04" {
  name                = "vm-07-server-04"  
  resource_group_name = azurerm_resource_group.rg-br-server-prd.name
  location            = azurerm_resource_group.rg-br-server-prd.location 
  network_interface_ids = [
    azurerm_network_interface.inet-01-vm-07-server-04.id
  ]
  vm_size                = "Standard_F4s_v2" # Standard_F8s_v2

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-vm-07-server-04"
    caching           = "ReadWrite"
    #disk_size_gb      = 32
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "server04"
    admin_username = "adminserver04"
    admin_password = "Pulsepulse@2021"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
  
  boot_diagnostics {
      enabled     = true
      storage_uri = "https://storagekserver.blob.core.windows.net/"
  }

  tags     = {
      "environment" = "prod"
      "project"  = "server"
  }
}

##########################
#                        #
#       VM03 server     #  
#                        #
##########################

#Criação da maquina virtual server 01 linux
resource "azurerm_virtual_machine" "vm-08-domain-01" {
  name                = "vm-08-domain-01"  
  resource_group_name = azurerm_resource_group.rg-br-server-prd.name
  location            = azurerm_resource_group.rg-br-server-prd.location 
  network_interface_ids = [
    azurerm_network_interface.inet-01-vm-08-domain-01.id,
    # azurerm_network_interface.inet-02-vm-08-domain-01.id,
  ]
  # primary_network_interface_id = azurerm_network_interface.inet-02-vm-08-domain-01.id
  vm_size                = "Standard_b2s" # Standard_F8s_v2

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-vm-08-domain-01"
    caching           = "ReadWrite"
    #disk_size_gb      = 32
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "domaincontrol"
    admin_username = "admindomain01"
    admin_password = "Pulsepulse@2021"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
  
  boot_diagnostics {
      enabled     = true
      storage_uri = "https://storagekserver.blob.core.windows.net/"
  }

  tags     = {
      "environment" = "prod"
      "project"  = "domain"
  }
}