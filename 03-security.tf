########################################
#                                      #
#       Network Security Groups        #  
#                                      #
########################################

 
 resource "azurerm_network_security_group" "nsg-snet-brarmazem-hub-gw" {
    location            = azurerm_resource_group.rg-br-server-prd.location
    name                = "snet-brarmazem-hub-gw-nsg"
    resource_group_name = azurerm_resource_group.rg-br-server-prd.name
    security_rule      {
        name                       = "SSH"
        description                = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule      {
        name                       = "Wireguard"
        description                = "Wireguard"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Udp"
        source_port_range          = "*"
        destination_port_range     = "51820"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags     = {
         "environment" = "prod"
         "project"  = "server"
     }

    timeouts {}
 }

resource "azurerm_network_security_group" "nsg-snet-brarmazem-prod-server-app" {
    name                = "nsg-snet-brarmazem-prod-server-app"
    location            = azurerm_resource_group.rg-br-server-prd.location
    resource_group_name = azurerm_resource_group.rg-br-server-prd.name  
    security_rule      {
        name                       = "SSH"
        description                = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule      {
        name                       = "Wireguard"
        description                = "Wireguard"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Udp"
        source_port_range          = "*"
        destination_port_range     = "51820"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }  
    
    security_rule  {
              access                                     = "Allow"
              description                                = ""
              destination_address_prefix                 = "*"
              destination_address_prefixes               = []
              destination_application_security_group_ids = []
              destination_port_range                     = "3389"
              destination_port_ranges                    = []
              direction                                  = "Inbound"
              name                                       = "Port_3389"
              priority                                   = 100
              protocol                                   = "TCP"
              source_address_prefix                      = "*"
              source_address_prefixes                    = []
              source_application_security_group_ids      = []
              source_port_range                          = "*"
              source_port_ranges                         = []
            }
    tags                = {
        "environment" = "prod"
    }

    timeouts {}
 }

resource "azurerm_network_security_group" "nsg-snet-brarmazem-prod-server-infra" {    
    name                = "nsg-snet-brarmazem-prod-server-infra"
    location            = azurerm_resource_group.rg-br-server-prd.location
    resource_group_name = azurerm_resource_group.rg-br-server-prd.name
    security_rule  {
              access                                     = "Allow"
              description                                = ""
              destination_address_prefix                 = "*"
              destination_address_prefixes               = []
              destination_application_security_group_ids = []
              destination_port_range                     = "3389"
              destination_port_ranges                    = []
              direction                                  = "Inbound"
              name                                       = "Port_3389"
              priority                                   = 100
              protocol                                   = "TCP"
              source_address_prefix                      = "*"
              source_address_prefixes                    = []
              source_application_security_group_ids      = []
              source_port_range                          = "*"
              source_port_ranges                         = []
            }
            
    tags                = {
        "environment" = "prod"
    }

    timeouts {}
 }


# resource "azurerm_network_security_group" "snet-brarmazem-hub-prod-server-infra-nsg" {
    
#     name                = "snet-brarmazem-hub-prod-server-infra-nsg"
#     location            = azurerm_resource_group.rg-br-server-prd.location
#     resource_group_name = azurerm_resource_group.rg-br-server-prd.name    
#     # security_rule      {
#     #     name                       = "RDP"
#     #     description                = "RDP"
#     #     priority                   = 1001
#     #     direction                  = "Inbound"
#     #     access                     = "Allow"
#     #     protocol                   = "Tcp"
#     #     source_port_range          = "*"
#     #     destination_port_range     = "3389"
#     #     source_address_prefix      = "*"
#     #     destination_address_prefix = azurerm_linux_virtual_machine.vm-01-dc-dns.inet-01-vm-01-dc-dns.private_ip_address
#     # }
#     # security_rule      {
#     #     name                       = "RDP"
#     #     description                = "RDP"
#     #     priority                   = 1002
#     #     direction                  = "Inbound"
#     #     access                     = "Allow"
#     #     protocol                   = "Tcp"
#     #     source_port_range          = "*"
#     #     destination_port_range     = "3389"
#     #     source_address_prefix      = "*"
#     #     destination_address_prefix = azurerm_linux_virtual_machine.inet-01-vm-02-cb-lic.private_ip_address
#     # }

#     tags                = {
#         "environment" = "prod"
#         "projeto"     = "server"
#     }

#     timeouts {}
# }

# resource "azurerm_network_security_group" "snet-brarmazem-hub-prod-server-app-nsg" {
#     name                = "snet-brarmazem-hub-prod-server-app-nsg"
#     location            = azurerm_resource_group.rg-br-server-prd.location
#     resource_group_name = azurerm_resource_group.rg-br-server-prd.name  
#     # security_rule      {
#     #     name                       = "RDP"
#     #     description                = "RDP"
#     #     priority                   = 1001
#     #     direction                  = "Inbound"
#     #     access                     = "Allow"
#     #     protocol                   = "Tcp"
#     #     source_port_range          = "*"
#     #     destination_port_range     = "3389"
#     #     source_address_prefix      = "*"
#     #     destination_address_prefix = azurerm_linux_virtual_machine.vm-06-server-02.inet-01-vm-06-server-02.private_ip_address
#     # }

#     # security_rule      {
#     #     name                       = "RDP"
#     #     description                = "RDP"
#     #     priority                   = 1002
#     #     direction                  = "Inbound"
#     #     access                     = "Allow"
#     #     protocol                   = "Tcp"
#     #     source_port_range          = "*"
#     #     destination_port_range     = "3389"
#     #     source_address_prefix      = "*"
#     #     destination_address_prefix = azurerm_virtual_machine.vm-03-server-01.inet-01-vm-03-server-01.private_ip_address
#     # }

#     tags                = {
#         "environment" = "prod"
#         "projeto"     = "server"
#     }

#     timeouts {}
# }

#Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "inet-01-vm-wireguard-ni-group-association" {
#     network_interface_id      = azurerm_network_interface.inet-01-vm-wireguard.id
#     network_security_group_id = azurerm_network_security_group.nsg-snet-brarmazem-hub-gw.id

# }

#Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "inet-02-vm-wireguard-ni-group-association" {
#     network_interface_id      = azurerm_network_interface.inet-02-vm-wireguard.id
#     network_security_group_id = azurerm_network_security_group.nsg-snet-brarmazem-prod-server-app.id

# }

#Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "inet-03-vm-wireguard-ni-group-association" {
#     network_interface_id      = azurerm_network_interface.inet-03-vm-wireguard.id
#     network_security_group_id = azurerm_network_security_group.nsg-snet-brarmazem-prod-server-infra.id

# }

#################################################################################
# nsg hub gw
#  resource "azurerm_network_security_group" "nsg-snet-grupo-hub-prod" {
#     location            = azurerm_resource_group.rg-br-infra-prod.location
#     name                = "snet-brarmazem-hub-gw-nsg"
#     resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
#     security_rule      {
#         name                       = "SSH"
#         description                = "SSH"
#         priority                   = 1001
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "22"
#         source_address_prefix      = "*"
#         destination_address_prefix = azurerm_linux_virtual_machine.vm-01-wireguard-gw-hub.private_ip_address
#     }

#     security_rule      {
#         name                       = "Wireguard"
#         description                = "Wireguard"
#         priority                   = 1002
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Udp"
#         source_port_range          = "*"
#         destination_port_range     = "51820"
#         source_address_prefix      = "*"
#         destination_address_prefix = azurerm_linux_virtual_machine.vm-01-wireguard-gw-hub.private_ip_address
#     }

#     tags     = {
#          "environment" = "prod"         
#      }

#     timeouts {}
#  }

#################################################################################
# nsg hub gw
#  resource "azurerm_network_security_group" "nsg-snet-grupo-linux-server" {
#     location            = azurerm_resource_group.rg-br-infra-prod.location
#     name                = "nsg-snet-grupo-linux-server"
#     resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
#     security_rule      {
#         name                       = "SSH"
#         description                = "SSH"
#         priority                   = 1001
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "22"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#     }

#     tags     = {
#          "environment" = "prod"         
#      }

#     timeouts {}
#  }


#Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "inet-01-vm-wireguard-hub-gw-ni-group-association" {
#     network_interface_id      = azurerm_network_interface.inet-01-vm-01-wireguard-gw-hub.id
#     network_security_group_id = azurerm_network_security_group.nsg-snet-grupo-hub-prod.id

# }

# #Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "inet-01-vm-01-linux-server-ni-group-association" {
#     network_interface_id      = azurerm_network_interface.inet-01-vm-01-linux-server.id
#     network_security_group_id = azurerm_network_security_group.nsg-snet-grupo-linux-server.id

# }

