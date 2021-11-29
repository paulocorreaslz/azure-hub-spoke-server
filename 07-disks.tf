# #Disco gerenciado (dados) disk-01-vm-03-server-01
# resource "azurerm_managed_disk" "disk-01-vm-03-server-01" {
#     name                 = "disk-01-vm-03-server-01"
#     location            = azurerm_resource_group.rg-br-server-prd.location
#     resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#     storage_account_type = "Standard_LRS"
#     create_option        = "Empty"
#     disk_size_gb         = "128"

#     tags = {
#         "ambiente"="prod"
#         "environment"="prod"
#     }
# }

# #Adicionar o disco criado disk-01-vm-03-server-01 a vm-03-server-01
# resource "azurerm_virtual_machine_data_disk_attachment" "disk-01-vm-03-server-01_attach_vm-03-server-01" {
#   managed_disk_id    = azurerm_managed_disk.disk-01-vm-03-server-01.id
#   virtual_machine_id = azurerm_virtual_machine.vm-03-server-01.id
#   lun                = "2"
#   caching            = "ReadWrite"
# }

# #Disco gerenciado (dados) disk-01-vm-06-server-02
# resource "azurerm_managed_disk" "disk-01-vm-06-server-02" {
#      name                 = "disk-01-vm-06-server-02"
#      location            = azurerm_resource_group.rg-br-server-prd.location
#      resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#      storage_account_type = "Standard_LRS"
#      create_option        = "Empty"
#      disk_size_gb         = "32"     

#     tags = {
#         "ambiente"="prod"
#         "environment"="prod"
#     }
# }

# #Adicionar o disco criado disk-01-vm-06-server-02 a vm-06-server-02
# resource "azurerm_virtual_machine_data_disk_attachment" "disk-01-vm-06-server-02_attach_vm-06-server-02" {
#   # managed_disk_id    = azurerm_managed_disk.disk-01-vm-06-server-02.id
#   # virtual_machine_id = azurerm_virtual_machine.vm-06-server-02.id
#   # lun                = "2"
#   # caching            = "ReadWrite"
#     caching                   = "ReadWrite"
#     create_option             = "Attach"
#     #id                        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-06-server-02/dataDisks/disk-01-vm-06-server-02"
#     lun                       = 2
#     managed_disk_id           = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/disk-01-vm-06-server-02"
#     virtual_machine_id        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-06-server-02"
#     write_accelerator_enabled = false
# }

# #Disco gerenciado (dados) disk-01-vm-03-server-01
# resource "azurerm_managed_disk" "disk-01-vm-03-server-01" {
#     name                 = "disk-01-vm-03-server-01"
#     location            = azurerm_resource_group.rg-br-server-prd.location
#     resource_group_name = azurerm_resource_group.rg-br-server-prd.name
#     storage_account_type = "Standard_LRS"
#     create_option        = "Empty"
#     disk_size_gb         = "128"

#     tags = {
#         "ambiente"="prod"
#         "environment"="prod"
#     }
# }

# #Adicionar o disco criado disk-01-vm-03-server-01 a vm-03-server-01
# resource "azurerm_virtual_machine_data_disk_attachment" "disk-01-vm-03-server-01_attach_vm-03-server-01" {
#   managed_disk_id    = azurerm_managed_disk.disk-01-vm-03-server-01.id
#   virtual_machine_id = azurerm_virtual_machine.vm-03-serverr-01.id
#   lun                = "2"
#   caching            = "ReadWrite"
# }

#Disco gerenciado (dados) disk-01-vm-03-server-01
resource "azurerm_managed_disk" "disk-01-vm-07-server-04" {
    name                 = "disk-01-vm-07-server-04"
    location            = azurerm_resource_group.rg-br-server-prd.location
    resource_group_name = azurerm_resource_group.rg-br-server-prd.name
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "128"

    tags = {
        "ambiente"="prod"
        "environment"="prod"
    }
}

#Adicionar o disco criado disk-01-vm-03-server-01 a vm-03-server-01
resource "azurerm_virtual_machine_data_disk_attachment" "disk-01-vm-07-server-04_attach_vm-07-server-04" {
  managed_disk_id    = azurerm_managed_disk.disk-01-vm-07-server-04.id
  virtual_machine_id = azurerm_virtual_machine.vm-07-server-04.id
  lun                = "2"
  caching            = "ReadWrite"
}


#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm01dcserverprd-osdisk-20210414-202359
resource "azurerm_managed_disk" "vm01dcserverprd-osdisk" {
   create_option        = "Import"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 127
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm01dcserverprd-osdisk-20210414-202359"
    location             = "brazilsouth"
    name                 = "vm01dcserverprd-osdisk-20210414-202359"
    os_type              = "Windows"
    resource_group_name  = "rg-br-server-prd"
    source_uri           = "https://storagekserver.blob.core.windows.net/vm01dcserverprd-7ca2981dbbe94f379d927f43de682a4e/vm01dcserverprd-osdisk-20210414-202359.vhd"
    storage_account_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Storage/storageAccounts/storagekserver"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "c2dfd23c-9de3-40b4-b268-81c37bba16ae"
        "environment"   = "prod"
        "project"       = "server"
    }
    zones                = []

    timeouts {}
}

# /subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm02cblicserver-osdisk-20210414-202713
resource "azurerm_managed_disk" "vm02cblicserver-osdisk"  {

    create_option        = "Import"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 127
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm02cblicserver-osdisk-20210414-202713"
    location             = "brazilsouth"
    name                 = "vm02cblicserver-osdisk-20210414-202713"
    os_type              = "Windows"
    resource_group_name  = "rg-br-server-prd"
    source_uri           = "https://storagekserver.blob.core.windows.net/vm02cblicserver-67bf5028cae54c909149c761d3524144/vm02cblicserver-osdisk-20210414-202713.vhd"
    storage_account_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Storage/storageAccounts/storagekserver"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "87b41144-46c2-41e6-a768-fa045f5f7a2e"
        "environment"   = "prod"
        "project"       = "server"
    }
    zones                = []

    timeouts {}
}

resource "azurerm_managed_disk" "vm03server01prd-osdisk" {
create_option        = "Import"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 127
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm03server01prd-osdisk-20210414-204259"
    location             = "brazilsouth"
    name                 = "vm03server01prd-osdisk-20210414-204259"
    os_type              = "Windows"
    resource_group_name  = "rg-br-server-prd"
    source_uri           = "https://storagekserver.blob.core.windows.net/vm03server01prd-90ceedaeca7f40059120ee12da02784e/vm03server01prd-osdisk-20210414-204259.vhd"
    storage_account_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Storage/storageAccounts/storagekserver"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "7efb1d8c-9a24-4219-a932-0ae13d6b3f6e"
        "environment"   = "prod"
        "project"       = "server"
    }
    zones                = []

    timeouts {}
}
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm03server01prd-datadisk-002-20210414-204259
resource "azurerm_managed_disk" "vm03server01prd-datadisk-01" {
 create_option        = "Import"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 128
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm03server01prd-datadisk-002-20210414-204259"
    location             = "brazilsouth"
    name                 = "vm03server01prd-datadisk-002-20210414-204259"
    resource_group_name  = "rg-br-server-prd"
    source_uri           = "https://storagekserver.blob.core.windows.net/vm03server01prd-90ceedaeca7f40059120ee12da02784e/vm03server01prd-datadisk-002-20210414-204259.vhd"
    storage_account_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Storage/storageAccounts/storagekserver"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "7efb1d8c-9a24-4219-a932-0ae13d6b3f6e"
        "ambiente"      = "prod"
        "environment"   = "prod"
    }
    zones                = []

    timeouts {}
}

resource "azurerm_managed_disk" "vm04wagwserver-osdisk"  {
    create_option        = "Import"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 127
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm04wagwserver-osdisk-20210414-203056"
    location             = "brazilsouth"
    name                 = "vm04wagwserver-osdisk-20210414-203056"
    os_type              = "Windows"
    resource_group_name  = "rg-br-server-prd"
    source_uri           = "https://storagekserver.blob.core.windows.net/vm04wagwserver-7d3ce28f08d244799c318e061f4bf357/vm04wagwserver-osdisk-20210414-203056.vhd"
    storage_account_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Storage/storageAccounts/storagekserver"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "6d8e6b8f-907d-4e75-958c-e399c72404ed"
        "environment"   = "prod"
        "project"       = "server"
    }
    zones                = []

    timeouts {}
}

resource "azurerm_managed_disk" "vm06server02prd-osdisk"  {
  create_option        = "Import"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 127
   # id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm06server02prd-osdisk-20210414-204123"
    location             = "brazilsouth"
    name                 = "vm06server02prd-osdisk-20210414-204123"
    os_type              = "Windows"
    resource_group_name  = "rg-br-server-prd"
    source_uri           = "https://storagekserver.blob.core.windows.net/vm06server02prd-d8913dc06fa146b8bf1939771671b6a3/vm06server02prd-osdisk-20210414-204123.vhd"
    storage_account_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Storage/storageAccounts/storagekserver"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "5fc0f93b-4b12-4d2f-985c-41d73fd65ce7"
        "environment"   = "prod"
        "project"       = "server"
    }
    zones                = []

    timeouts {}

}

resource "azurerm_managed_disk" "vm06server02prd-datadisk" {
  create_option        = "Import"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 32
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm06server02prd-datadisk-002-20210414-204123"
    location             = "brazilsouth"
    name                 = "vm06server02prd-datadisk-002-20210414-204123"
    resource_group_name  = "rg-br-server-prd"
    source_uri           = "https://storagekserver.blob.core.windows.net/vm06server02prd-d8913dc06fa146b8bf1939771671b6a3/vm06server02prd-datadisk-002-20210414-204123.vhd"
    storage_account_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Storage/storageAccounts/storagekserver"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "5fc0f93b-4b12-4d2f-985c-41d73fd65ce7"
        "ambiente"      = "prod"
        "environment"   = "prod"
    }
    zones                = []

    timeouts {}
}

resource "azurerm_managed_disk" "vm06server03prd-osdisk" {
 create_option        = "Restore"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 127
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm06server03prd-osdisk-20210423-174939"
    location             = "brazilsouth"
    name                 = "vm06server03prd-osdisk-20210423-174939"
    os_type              = "Windows"
    resource_group_name  = "rg-br-server-prd"
    source_resource_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/AzureBackupRG_brazilsouth_1/providers/Microsoft.Compute/restorePointCollections/AzureBackup_vm-03-serverr-01_4283222314680776760/restorePoints/AzureBackup_20210423_030312/disks/osdisk-vm-03-serverr-01?id=615b64e3-82bf-42d6-9dfc-3e6f4b9e6df8"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "79a59954-f060-4d74-9180-354c0eda2264"
        "environment"   = "prod"
        "project"       = "server"
    }
    zones                = []

    timeouts {}
}

resource "azurerm_managed_disk" "vm06server03prd-datadisk" {
   create_option        = "Restore"
    disk_iops_read_write = 500
    disk_mbps_read_write = 60
    disk_size_gb         = 128
    #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/disks/vm06server03prd-datadisk-002-20210423-174939"
    location             = "brazilsouth"
    name                 = "vm06server03prd-datadisk-002-20210423-174939"
    resource_group_name  = "rg-br-server-prd"
    source_resource_id   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/AzureBackupRG_brazilsouth_1/providers/Microsoft.Compute/restorePointCollections/AzureBackup_vm-03-serverr-01_4283222314680776760/restorePoints/AzureBackup_20210423_030312/disks/disk-01-vm-03-server-01?id=d6244f75-ffff-4282-a4a1-100a2b1ad49c"
    storage_account_type = "Standard_LRS"
    tags                 = {
        "RSVaultBackup" = "79a59954-f060-4d74-9180-354c0eda2264"
        "ambiente"      = "prod"
        "environment"   = "prod"
    }
    zones                = []

    timeouts {}
}