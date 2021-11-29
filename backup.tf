resource "azurerm_recovery_services_vault" "vault-brarmazem-bkp" {

    name                = "vault-brarmazem-bkp"
    location            = azurerm_resource_group.rg-br-infra-prod.location
    resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
    sku                 = "Standard"
    soft_delete_enabled = true
    tags                = {
      "environment" = "prod"
    }    

    timeouts {}
}


resource "azurerm_backup_policy_vm" "dp-security-server" {
  
    instant_restore_retention_days = 2
    name                           = "dp-security-server"
    recovery_vault_name            = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
    resource_group_name            = azurerm_resource_group.rg-br-infra-prod.name
    tags                           = {}
    timezone                       = "E. South America Standard Time"

    backup {
        frequency = "Daily"
        time      = "00:00"
        weekdays  = []
    }

    retention_daily {
        count = 30
    }

    timeouts {}
}

# resource "azurerm_backup_protected_vm" "bkp-vm-03-server-01" {
#   resource_group_name       = azurerm_resource_group.rg-br-infra-prod.name
#   recovery_vault_name = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
#   source_vm_id        = azurerm_virtual_machine.vm-03-server-01.id
#   backup_policy_id    = azurerm_backup_policy_vm.dp-security-server.id
# }

#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;rg-br-server-prd;vm-03-server-01-prd/protectedItems/VM;iaasvmcontainerv2;rg-br-server-prd;vm-03-server-01-prd
#
 resource "azurerm_backup_protected_vm" "bkp-vm-03-server-01"  {
    backup_policy_id    = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupPolicies/dp-security-server"
    #id                  = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;rg-br-server-prd;vm-03-server-01-prd/protectedItems/VM;iaasvmcontainerv2;rg-br-server-prd;vm-03-server-01-prd"
    recovery_vault_name = "vault-brarmazem-bkp"
    resource_group_name = "rg-br-infra-prod"
    source_vm_id        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-03-server-01-prd"
    tags                = {}

    timeouts {}

 }

#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;rg-br-server-prd;vm-06-server-02-prd/protectedItems/VM;iaasvmcontainerv2;rg-br-server-prd;vm-06-server-02-prd
resource "azurerm_backup_protected_vm" "bkp-vm-06-server-02" {
  backup_policy_id    = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupPolicies/dp-security-server"
    #id                  = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;rg-br-server-prd;vm-06-server-02-prd/protectedItems/VM;iaasvmcontainerv2;rg-br-server-prd;vm-06-server-02-prd"
    recovery_vault_name = "vault-brarmazem-bkp"
    resource_group_name = "rg-br-infra-prod"
    source_vm_id        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-06-server-02-prd"
    tags                = {}

    timeouts {}
}

resource "azurerm_backup_protected_vm" "bkp-vm-06-server-03-prd"  {
    backup_policy_id    = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupPolicies/dp-security-server"
    #id                  = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;RG-BR-server-PRD;vm-06-server-03-prd/protectedItems/VM;iaasvmcontainerv2;RG-BR-server-PRD;vm-06-server-03-prd"
    recovery_vault_name = "vault-brarmazem-bkp"
    resource_group_name = "rg-br-infra-prod"
    source_vm_id        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/RG-BR-server-PRD/providers/Microsoft.Compute/virtualMachines/vm-06-server-03-prd"
    tags                = {}

    timeouts {}
}

 #resource "azurerm_backup_protected_vm" "bkp-vm-06-server-02" {
  # resource_group_name       = azurerm_resource_group.rg-br-infra-prod.name
  # recovery_vault_name = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
  # source_vm_id        = azurerm_virtual_machine.vm-06-server-02.id
  # backup_policy_id    = azurerm_backup_policy_vm.dp-security-server.id
 #}

# /subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;RG-BR-server-PRD;vm-01-dc-dns/protectedItems/VM;iaasvmcontainerv2;RG-BR-server-PRD;vm-01-dc-dns
resource "azurerm_backup_protected_vm" "bkp-vm-01-dc-dns" {
    backup_policy_id    = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupPolicies/dp-security-server"
    #id                  = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;RG-BR-server-PRD;vm-01-dc-dns/protectedItems/VM;iaasvmcontainerv2;RG-BR-server-PRD;vm-01-dc-dns"
    recovery_vault_name = "vault-brarmazem-bkp"
    resource_group_name = "rg-br-infra-prod"
    source_vm_id        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-01-dc-dns"
    tags                = {}

    timeouts {}
}

# resource "azurerm_backup_protected_vm" "bkp-vm-01-dc-dns" {
#   resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
#   recovery_vault_name = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
#   source_vm_id        = azurerm_virtual_machine.vm-01-dc-dns.id
#   backup_policy_id    = azurerm_backup_policy_vm.dp-security-server.id
# }

#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;rg-br-server-prd;vm-02-cb-lic/protectedItems/VM;iaasvmcontainerv2;rg-br-server-prd;vm-02-cb-lic
resource "azurerm_backup_protected_vm" "bkp-vm-02-cb-lic" {
    backup_policy_id    = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupPolicies/dp-security-server"
    #id                  = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;rg-br-server-prd;vm-02-cb-lic/protectedItems/VM;iaasvmcontainerv2;rg-br-server-prd;vm-02-cb-lic"
    recovery_vault_name = "vault-brarmazem-bkp"
    resource_group_name = "rg-br-infra-prod"
    source_vm_id        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-02-cb-lic"
    tags                = {}

    timeouts {}
}


# resource "azurerm_backup_protected_vm" "bkp-vm-02-cb-lic" {
#   resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
#   recovery_vault_name = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
#   source_vm_id        = azurerm_virtual_machine.vm-02-cb-lic.id
#   backup_policy_id    = azurerm_backup_policy_vm.dp-security-server.id
# }


# resource "azurerm_backup_protected_vm" "bkp-vm-04-wa-gw" {
#   resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
#   recovery_vault_name = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
#   source_vm_id        = azurerm_virtual_machine.vm-04-wa-gw.id
#   backup_policy_id    = azurerm_backup_policy_vm.dp-security-server.id
# }

resource "azurerm_backup_protected_vm" "bkp-vm-04-wa-gw" {
    backup_policy_id    = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupPolicies/dp-security-server"
    #id                  = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.RecoveryServices/vaults/vault-brarmazem-bkp/backupFabrics/Azure/protectionContainers/IaasVMContainer;iaasvmcontainerv2;rg-br-server-prd;vm-04-wa-gw/protectedItems/VM;iaasvmcontainerv2;rg-br-server-prd;vm-04-wa-gw"
    recovery_vault_name = "vault-brarmazem-bkp"
    resource_group_name = "rg-br-infra-prod"
    source_vm_id        = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-04-wa-gw"
    tags                = {}

    timeouts {}
}

resource "azurerm_backup_protected_vm" "bkp-vm-07-server-04" {
  resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
  recovery_vault_name = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
  source_vm_id        = azurerm_virtual_machine.vm-07-server-04.id
  backup_policy_id    = azurerm_backup_policy_vm.dp-security-server.id
}

resource "azurerm_backup_protected_vm" "bkp-vm-08-domain-01" {
  resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
  recovery_vault_name = azurerm_recovery_services_vault.vault-brarmazem-bkp.name
  source_vm_id        = azurerm_virtual_machine.vm-08-domain-01.id
  backup_policy_id    = azurerm_backup_policy_vm.dp-security-server.id
}