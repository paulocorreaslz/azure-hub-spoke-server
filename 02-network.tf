# resource "azurerm_virtual_network" "vnet-brarmazem-server-prod" {
#     address_space       = [
#         "172.20.0.0/24",
#         "172.20.1.0/24",
#         "172.20.2.0/24",
#         "172.20.99.0/24"
#     ]
#     dns_servers         = []
#     location            = azurerm_resource_group.rg-br-server-prd.location
#     name                = "vnet-brarmazem-server-prod"
#     resource_group_name = azurerm_resource_group.rg-br-server-prd.name
   
#     tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

#vnet-grupo-hub-prod (172.25.0.0/16)
#   - subnet-grupo-hub-prod (172.25.0.0/24)
#   - subnet-grupo-hub-app-prod (172.25.01.0/24)
 
 #- vnet-grupo-spoke-prod (172.26.0.0/16)
 #   - subnet-grupo-server-prod (172.26.1.0/24)
 #   - subnet-grupo-aplicacao-prod (172.26.2.0/24)

resource "azurerm_virtual_network" "vnet-grupo-hub-prod" {
    address_space       = [
        "172.25.0.0/16"
    ]
    dns_servers         = ["192.168.6.144"]
    location            = azurerm_resource_group.rg-br-infra-prod.location
    name                = "vnet-grupo-hub-prod"
    resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
   
    tags     = {
         "environment" = "prod"         
     }
}

 resource "azurerm_subnet" "subnet-grupo-hub-prod"{

    name                                           = "subnet-grupo-hub-prod"
    address_prefixes                               = ["172.25.0.0/24"]
    resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name
    virtual_network_name                           = azurerm_virtual_network.vnet-grupo-hub-prod.name
    timeouts {}
}

 resource "azurerm_subnet" "subnet-grupo-hub-app-prod"{

    name                                           = "subnet-grupo-hub-app-prod"
    address_prefixes                               = ["172.25.1.0/24"]
    resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name
    virtual_network_name                           = azurerm_virtual_network.vnet-grupo-hub-prod.name
    timeouts {}
}

resource "azurerm_virtual_network" "vnet-grupo-spoke-prod" {
    address_space       = [        
        "172.26.0.0/16",        
        "172.20.0.0/16",
    ]
    dns_servers         = ["192.168.6.144"]
    location            = azurerm_resource_group.rg-br-infra-prod.location
    name                = "vnet-grupo-spoke-prod"
    resource_group_name = azurerm_resource_group.rg-br-infra-prod.name
   
    tags     = {
         "environment" = "prod"         
     }
}

 resource "azurerm_subnet" "subnet-grupo-server-gw-prod"{

    name                                           = "subnet-grupo-server-gw-prod"
    address_prefixes                               = ["172.20.0.0/24"]
    resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name
    virtual_network_name                           = azurerm_virtual_network.vnet-grupo-spoke-prod.name
    timeouts {}
}

 resource "azurerm_subnet" "subnet-grupo-server-infra-prod"{

    name                                           = "subnet-grupo-server-infra-prod"              
    address_prefixes                               = ["172.20.2.0/24"]
    resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name        
    virtual_network_name                           = azurerm_virtual_network.vnet-grupo-spoke-prod.name
    timeouts {}

 }

  resource "azurerm_subnet" "subnet-grupo-server-app-prod"{
    name                                           = "subnet-grupo-server-app-prod"   
    address_prefixes                               = ["172.20.1.0/24"]  
    enforce_private_link_endpoint_network_policies = true
    resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name
    virtual_network_name                           = azurerm_virtual_network.vnet-grupo-spoke-prod.name
    timeouts {}
    
  }

  resource "azurerm_subnet" "subnet-grupo-data-app-prod"{
    name                                           = "subnet-grupo-data-app-prod"   
    address_prefixes                               = ["172.20.4.0/24"]  
    enforce_private_link_endpoint_network_policies = true
    resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name
    virtual_network_name                           = azurerm_virtual_network.vnet-grupo-spoke-prod.name
    service_endpoints                              = ["Microsoft.Storage"]
    timeouts {}
    
  }



#  #   - subnet-grupo-server-prod (172.26.1.0/24)
#  #   - subnet-grupo-aplicacao-prod (172.26.2.0/24)
#  resource "azurerm_subnet" "subnet-grupo-hub-app-prod"{

#     name                                           = "subnet-grupo-hub-app-prod"
#     address_prefixes                               = ["172.26.1.0/24"]
#     resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name
#     virtual_network_name                           = azurerm_virtual_network.vnet-grupo-spoke-prod.name
#     timeouts {}
# }
 #REMOVER
#  resource "azurerm_subnet" "subnet-grupo-aplicacao-prod"{

#     name                                           = "subnet-grupo-aplicacao-prod"
#     address_prefixes                               = ["172.26.2.0/24"]
#     resource_group_name                            = azurerm_resource_group.rg-br-infra-prod.name
#     virtual_network_name                           = azurerm_virtual_network.vnet-grupo-spoke-prod.name
#     timeouts {}
# }

######################################################################################################
#peerings
########################################################################################

#enable global peering between the two virtual network
resource "azurerm_virtual_network_peering" "peeringhubtospoke" {  
  name                         = "peering_hub_to_spoke"
  resource_group_name          = azurerm_resource_group.rg-br-infra-prod.name
  virtual_network_name         = azurerm_virtual_network.vnet-grupo-hub-prod.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-grupo-spoke-prod.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = true
}


resource "azurerm_virtual_network_peering" "peeringspoketohub" {  
  name                         = "peering_spoke_to_hub"
  resource_group_name          = azurerm_resource_group.rg-br-infra-prod.name
  virtual_network_name         = azurerm_virtual_network.vnet-grupo-spoke-prod.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-grupo-hub-prod.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = true
}

# resource "azurerm_virtual_network_peering" "vnet-grupo-hub-prod_to_vnet-grupo-spoke-qas-dev" {
#     name                  = "vnet-grupo-hub-prod_to_vnet-grupo-spoke-qas-dev"
#     #id                   = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-hub-prod"
#     resource_group_name  = "rg-br-infra-prod"
#     virtual_network_name = "vnet-grupo-hub-prod"
#     remote_virtual_network_id    = azurerm_virtual_network.vnet-grupo-hub-prod.id

#     timeouts {}
# }

######################################################################################################
# route table subnet-grupo-server-prod
######################################################################################################
resource "azurerm_route_table" "routetablevnetspoke" {
  disable_bgp_route_propagation = false
    # id                            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/routeTables/routetablevnetspoke"
    location                      = "brazilsouth"
    name                          = "routetablevnetspoke"
    resource_group_name           = "rg-br-infra-prod"
    route                         = [
        {
            address_prefix         = "172.25.0.0/16"
            name                   = "rota1"
            next_hop_in_ip_address = "172.25.0.5"
            next_hop_type          = "VirtualAppliance"
        },
        {
            address_prefix         = "10.0.0.0/8"
            name                   = "rota2"
            next_hop_in_ip_address = "172.25.0.5"
            next_hop_type          = "VirtualAppliance"
        },
        {
            address_prefix         = "192.168.0.0/16"
            name                   = "rota3"
            next_hop_in_ip_address = "172.25.0.5"
            next_hop_type          = "VirtualAppliance"
        },
        {
            address_prefix         = "172.16.0.0/12"
            name                   = "rota4"
            next_hop_in_ip_address = "172.25.0.5"
            next_hop_type          = "VirtualAppliance"
        },
    ]
    # subnets                       = [
    #     "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-app-prod",
    #     "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-gw-prod",
    #     "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-infra-prod",
    # ]
    tags                          = {
        "environment" = "prod"
    }

    timeouts {}
}

# resource "azurerm_subnet_route_table_association" "routesubnethubapp" {
#   subnet_id      = azurerm_subnet.subnet-grupo-hub-app-prod.id
#   route_table_id = azurerm_route_table.routetablevnethub.id
# }

# resource "azurerm_subnet_route_table_association" "routesubnetaplicacao" {
#   subnet_id      = azurerm_subnet.subnet-grupo-aplicacao-prod.id
#   route_table_id = azurerm_route_table.routetablevnetspoke.id
# }

resource "azurerm_subnet_route_table_association" "routesubnetservergw" {
  subnet_id      = azurerm_subnet.subnet-grupo-server-gw-prod.id
  route_table_id = azurerm_route_table.routetablevnetspoke.id
}
resource "azurerm_subnet_route_table_association" "routesubnetserverinfra" {
  subnet_id      = azurerm_subnet.subnet-grupo-server-infra-prod.id
  route_table_id = azurerm_route_table.routetablevnetspoke.id
}
resource "azurerm_subnet_route_table_association" "routesubnetserverapp" {
  subnet_id      = azurerm_subnet.subnet-grupo-server-app-prod.id
  route_table_id = azurerm_route_table.routetablevnetspoke.id
}

######################################################################################################



# resource "azurerm_route_table" "routetablevnethub" {

# resource "azurerm_route_table" "routetablevnethub" {
#   name                          = "routetablevnethub"
#   location                      = azurerm_resource_group.rg-br-infra-prod.location
#   resource_group_name           = azurerm_resource_group.rg-br-infra-prod.name
#   disable_bgp_route_propagation = false

#   route {
#     name           = "rota1"
#     address_prefix = "10.0.0.0/8"
#     next_hop_type  = "VirtualAppliance"
#     next_hop_in_ip_address = "172.25.0.5"
#   }

#   # route {
#   #   name           = "rota2"
#   #   address_prefix = "172.25.0.0/16"
#   #   next_hop_type  = "VirtualAppliance"
#   #   next_hop_in_ip_address = "172.25.0.5"
#   # }

#   route {
#     name           = "rota3"
#     address_prefix = "192.168.0.0/16"
#     next_hop_type  = "VirtualAppliance"
#     next_hop_in_ip_address = "172.25.0.5"
#   }

#   route {
#     name           = "rota4"
#     address_prefix = "172.16.0.0/12"
#     next_hop_type  = "VirtualAppliance"
#     next_hop_in_ip_address = "172.25.0.5"
#   }

#   tags = {
#     environment = "prod"
#   }
# }

# resource "azurerm_subnet_route_table_association" "routesubnethub" {
#   subnet_id      = azurerm_subnet.subnet-grupo-hub-prod.id
#   route_table_id = azurerm_route_table.routetablevnetspoke.id
# }

######################################################################################################
#  resource "azurerm_subnet" "snet-brarmazem-hub-gw"{

#     name                                           = "snet-brarmazem-hub-gw"
#     address_prefixes                               = ["172.20.0.0/24"]
#     resource_group_name                            = azurerm_resource_group.rg-br-server-prd.name
#     virtual_network_name                           = azurerm_virtual_network.vnet-brarmazem-server-prod.name
#     timeouts {}
# }

#  resource "azurerm_subnet" "snet-brarmazem-hub-prod-server-infra"{

#     name                                           = "snet-brarmazem-hub-prod-server-infra"              
#     address_prefixes                               = ["172.20.2.0/24"]
#     resource_group_name                            = azurerm_resource_group.rg-br-server-prd.name        
#     virtual_network_name                           = azurerm_virtual_network.vnet-brarmazem-server-prod.name
#     timeouts {}

#  }

#   resource "azurerm_subnet" "snet-brarmazem-hub-prod-server-app"{
#     name                                           = "snet-brarmazem-hub-prod-server-app"   
#     address_prefixes                               = ["172.20.1.0/24"]  
#     resource_group_name                            = azurerm_resource_group.rg-br-server-prd.name
#     virtual_network_name                           = azurerm_virtual_network.vnet-brarmazem-server-prod.name
#     timeouts {}
    
#   }

# resource   "azurerm_public_ip"   "pip-ip-vm-wirequard"   { 
#    name                 =   "pip-ip-vm-wirequard" 
#    location             =   azurerm_resource_group.rg-br-server-prd.location 
#    resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name
#    allocation_method    =   "Static" 
#    sku                 = "Standard"
#    tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#     }
# } 

# resource   "azurerm_public_ip"   "pip-ip-vm-wa-gw"   { 
#    name                 =   "pip-ip-vm-wa-gw" 
#    location             =   azurerm_resource_group.rg-br-server-prd.location 
#    resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name
#    allocation_method    =   "Static" 
#    tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#     }
# } 

# resource   "azurerm_public_ip"   "pip-ip-vm-dc-dns"   { 
#    name                 =   "pip-ip-vm-dc-dns" 
#    location             =   azurerm_resource_group.rg-br-server-prd.location 
#    resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name
#    allocation_method    =   "Static" 
#    tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#     }
# } 

# resource   "azurerm_public_ip"   "pip-ip-vm-cb-lic"   { 
#    name                 =   "pip-ip-vm-cb-lic" 
#    location             =   azurerm_resource_group.rg-br-server-prd.location 
#    resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name
#    allocation_method    =   "Static" 
#    tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#     }
# } 

# resource   "azurerm_public_ip"   "pip-ip-vm-server1"   { 
#    name                 =   "pip-ip-vm-server1" 
#    location             =   azurerm_resource_group.rg-br-server-prd.location 
#    resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name
#    allocation_method    =   "Static" 
#    tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#     }
# } 

# resource   "azurerm_public_ip"   "pip-ip-vm-server2"   { 
#    name                 =   "pip-ip-vm-server2" 
#    location             =   azurerm_resource_group.rg-br-server-prd.location 
#    resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name
#    allocation_method    =   "Static" 
#    tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#     }
# } 

# resource "azurerm_subnet" "snet-bastiao" {
#   name                 = "AzureBastionSubnet"
#   resource_group_name  =  azurerm_resource_group.rg-br-server-prd.name
#   virtual_network_name =  azurerm_virtual_network.vnet-brarmazem-server-prod.name
#   address_prefixes     = ["172.20.99.0/24"]
# }

# resource   "azurerm_public_ip"   "pip-ip-bastiao-host"   { 
#    name                 =   "pip-ip-bastiao-host" 
#    location             =   azurerm_resource_group.rg-br-server-prd.location 
#    resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name
#    allocation_method    =   "Static" 
#    sku                 = "Standard"
#    tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#     }
# } 

# resource "azurerm_bastion_host" "bastiao-host" {
#   name                 = "bastiao-host"
#   location             =   azurerm_resource_group.rg-br-server-prd.location 
#   resource_group_name  =   azurerm_resource_group.rg-br-server-prd.name

#   ip_configuration {
#     name                 = "bastiao-host-conf"
#     subnet_id            = azurerm_subnet.snet-bastiao.id    
#     public_ip_address_id = azurerm_public_ip.pip-ip-bastiao-host.id
#   }
#   tags = {
#     "environment"="prod"
#   }
# }


#========================================================================================================#
#                                 INICIO DE CONFIGURAÇÃO DE INTERFACES DE REDE                           #
#========================================================================================================#


# #SAI
# #Criacao de interface de rede privada da vm-05-wireguard
# resource "azurerm_network_interface" "inet-01-vm-wireguard" {
#     name                      = "inet-01-vm-wireguard"
#     location                  = azurerm_resource_group.rg-br-server-prd.location
#     resource_group_name       = azurerm_resource_group.rg-br-server-prd.name
#     enable_ip_forwarding = true 
 
#   ip_configuration{
#     name                          = "pip-vm-05-wireguard"
#     public_ip_address_id          = azurerm_public_ip.pip-ip-vm-wirequard.id
#     private_ip_address_allocation = "static"
#     private_ip_address            = "172.20.0.254" 
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-gw.id
#   }

#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

# #SAI
# #Criacao de interface de rede privada inet-02-vm-wireguard
# resource "azurerm_network_interface" "inet-02-vm-wireguard" {
#   name                = "inet-02-vm-wireguard"
#   enable_ip_forwarding          = true
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-prod-server-app.id
#     private_ip_address_allocation = "static"   
#     private_ip_address            = "172.20.1.254" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

# #SAI
# #Criacao de interface de rede privada inet-03-vm-wireguard
# resource "azurerm_network_interface" "inet-03-vm-wireguard" {
#   name                = "inet-03-vm-wireguard"
#   enable_ip_forwarding          = true
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-prod-server-infra.id
#     private_ip_address_allocation = "static"   
#     private_ip_address            = "172.20.2.254" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

#FICA
#Criacao de interface de rede privada da vm-03-server-01
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-03-server-01-prd-nic-09b6e41c655d41338881f4b6491e9442
resource "azurerm_network_interface" "inet-01-vm-03-server-01-prd"  {
    #applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    #id                            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-03-server-01-prd-nic-09b6e41c655d41338881f4b6491e9442"
    #internal_domain_name_suffix   = "3zn0uoaoi2dunj3y3fdtym0pec.nx.internal.cloudapp.net"
    location                      = "brazilsouth"
    #mac_address                   = "00-0D-3A-C1-07-FD"
    name                          = "vm-03-server-01-prd-nic-09b6e41c655d41338881f4b6491e9442"
    #private_ip_address            = "172.20.1.10"
    # private_ip_addresses          = [
    #     "172.20.1.10",
    # ]
    resource_group_name           = "rg-br-server-prd"
    tags                          = {
        "environment" = "prod"
    }
    #virtual_machine_id            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-03-server-01-prd"

    ip_configuration {
        name                          = "78bbc6ce474548599239975e4237d32c"
        primary                       = true
        private_ip_address            = "172.20.1.10"
        private_ip_address_allocation = "Static"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-app-prod"
    }

    timeouts {}
}
# resource "azurerm_network_interface" "inet-01-vm-03-server-01" {
#   name                = "inet-01-vm-03-server-01"
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   #dns_servers = ["172.20.2.10"]

#   ip_configuration {
#     name                          = "internal"    
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-prod-server-app.id ###
#     #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-server1.id
#     private_ip_address_allocation = "static"   
#     private_ip_address              = "172.20.1.10" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

# #Criacao de interface de rede privada da vm-06-server-02
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-06-server-02-prd-nic-6a66ae1e1a8a4598bbc194d0c88c07f1
 resource "azurerm_network_interface" "inet-01-vm-06-server-02-prd" {

  #  applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    # id                            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-06-server-02-prd-nic-6a66ae1e1a8a4598bbc194d0c88c07f1"
    # internal_domain_name_suffix   = "3zn0uoaoi2dunj3y3fdtym0pec.nx.internal.cloudapp.net"
    location                      = "brazilsouth"
    # mac_address                   = "00-22-48-35-C7-8B"
    name                          = "vm-06-server-02-prd-nic-6a66ae1e1a8a4598bbc194d0c88c07f1"
    # private_ip_address            = "172.20.1.11"
    # private_ip_addresses          = [
    #     "172.20.1.11",
    # ]
    resource_group_name           = "rg-br-server-prd"
    tags                          = {
        "environment" = "prod"
    }
    # virtual_machine_id            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-06-server-02-prd"

    ip_configuration {
        name                          = "5e737df79bfa4486bba101b23da84adf"
        primary                       = true
        private_ip_address            = "172.20.1.11"
        private_ip_address_allocation = "Static"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-app-prod"
    }

    timeouts {}
 }
# resource "azurerm_network_interface" "inet-01-vm-06-server-02" {
#   name                = "inet-01-vm-06-server-02"
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   #dns_servers = ["172.20.2.10"]

#   ip_configuration {
#     name                          = "internal"    
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-prod-server-app.id ###
#     #public_ip_address_id         = azurerm_public_ip.pip-ip-vm-server2.id
#     private_ip_address_allocation = "Dynamic"   
#     private_ip_address            = "172.20.1.11" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

# #Criacao de interface de rede privada da vm-01-dc-dns
# resource "azurerm_network_interface" "inet-01-vm-01-dc-dns" {
#   name                = "inet-01-vm-01-dc-dns"
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   ip_configuration {
#     name                          = "internal"
#     #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-dc-dns.id
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-prod-server-infra.id ###
#     private_ip_address_allocation = "static"   
#     private_ip_address              = "172.20.2.10" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-01-dc-server-prd-nic-4463ac85103645399511baa70fa5dba2

 resource "azurerm_network_interface" "inet-01-vm-01-dc-dns" {
    #applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    #id                            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-01-dc-server-prd-nic-4463ac85103645399511baa70fa5dba2"
    #internal_domain_name_suffix   = "3zn0uoaoi2dunj3y3fdtym0pec.nx.internal.cloudapp.net"
    location                      = "brazilsouth"
    #mac_address                   = "00-22-48-36-1A-0C"
    name                          = "vm-01-dc-server-prd-nic-4463ac85103645399511baa70fa5dba2"
    #private_ip_address            = "172.20.2.10"
    #private_ip_addresses          = [
    #    "172.20.2.10",
    #]
    resource_group_name           = "rg-br-server-prd"
    tags                          = {
        "environment" = "prod"
    }
    #virtual_machine_id            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-01-dc-server-prd"

    ip_configuration {
        name                          = "40f2dae647924f3ba4474fee8de2a86c"
        primary                       = true
        private_ip_address            = "172.20.2.10"
        private_ip_address_allocation = "Static"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-infra-prod"
    }

    timeouts {}
 }

# resource "azurerm_network_interface" "inet-02-vm-01-dc-dns" {
#   name                = "inet-02-vm-01-dc-dns"
#   location            = azurerm_resource_group.rg-br-infra-prod.location
#   resource_group_name = azurerm_resource_group.rg-br-infra-prod.name

#   ip_configuration {
#     name                          = "internal"
#     #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-dc-dns.id
#     subnet_id                     = azurerm_subnet.subnet-grupo-server-infra-prod.id ###
#     private_ip_address_allocation = "static"   
#     private_ip_address              = "172.20.2.10" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

# #Criacao de interface de rede privada da vm-02-cb-lic
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-02-cb-lic-server-nic-9d95d3de9f7846aeb64b1fabde78e582
resource "azurerm_network_interface" "inet-01-vm-02-cb-lic" {
#  applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    # id                            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-02-cb-lic-server-nic-9d95d3de9f7846aeb64b1fabde78e582"
    #internal_domain_name_suffix   = "3zn0uoaoi2dunj3y3fdtym0pec.nx.internal.cloudapp.net"
    location                      = "brazilsouth"
    #mac_address                   = "00-22-48-36-FB-0E"
    name                          = "vm-02-cb-lic-server-nic-9d95d3de9f7846aeb64b1fabde78e582"
    # private_ip_address            = "172.20.2.11"
    # private_ip_addresses          = [
    #     "172.20.2.11",
    # ]
    resource_group_name           = "rg-br-server-prd"
    tags                          = {
        "environment" = "prod"
    }
    #virtual_machine_id            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-02-cb-lic-server"

    ip_configuration {
        name                          = "fbe77930b4e34986931485570d95727c"
        primary                       = true
        private_ip_address            = "172.20.2.11"
        private_ip_address_allocation = "Static"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-infra-prod"
    }

    timeouts {}
}

# resource "azurerm_network_interface" "inet-01-vm-02-cb-lic" {
#   name                = "inet-01-vm-02-cb-lic"
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   #dns_servers = ["172.20.2.10"]

#   ip_configuration {
#     name                          = "internal"
#     #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-cb-lic.id
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-prod-server-infra.id ###
#     private_ip_address_allocation = "static"
#     private_ip_address              = "172.20.2.11" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

# #Criacao de interface de rede privada da vm-04-wa-gw
 resource "azurerm_network_interface" "inet-01-vm-04-wa-gw-server"  {
  # applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    # id                            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/networkInterfaces/vm-04-wa-gw-server-nic-eff36e263d72432097013b15eec07130"
    # internal_domain_name_suffix   = "3zn0uoaoi2dunj3y3fdtym0pec.nx.internal.cloudapp.net"
    location                      = "brazilsouth"
    # mac_address                   = "00-22-48-36-07-85"
    name                          = "vm-04-wa-gw-server-nic-eff36e263d72432097013b15eec07130"
    # private_ip_address            = "172.20.0.250"
    # private_ip_addresses          = [
    #     "172.20.0.250",
    # ]
    resource_group_name           = "rg-br-server-prd"
    tags                          = {
        "environment" = "prod"
    }
    # virtual_machine_id            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Compute/virtualMachines/vm-04-wa-gw-server"

    ip_configuration {
        name                          = "acf91dbd43e04fc2891b9a78977c542d"
        primary                       = true
        private_ip_address            = "172.20.0.250"
        private_ip_address_allocation = "Static"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/subnet-grupo-server-gw-prod"
    }

    timeouts {}
 }

#========================================================================================================#
#                                 FINAL DE CONFIGURAÇÃO DE INTERFACES DE REDE                            #
#========================================================================================================#



# resource "azurerm_network_interface" "inet-01-vm-04-wa-gw" {
#   name                = "inet-01-vm-04-wa-gw"
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   #dns_servers = ["172.20.2.10"]

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.snet-brarmazem-hub-gw.id
#     #public_ip_address_id = azurerm_public_ip.pip-ip-vm-wa-gw.id
#     private_ip_address_allocation = "static"
#     private_ip_address              = "172.20.0.250" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

#################################################################################


resource   "azurerm_public_ip"   "pip-ip-vm-wirequard-gw-hub"   { 
   name                 =   "pip-ip-vm-wirequard-gw-hub" 
   location             =   azurerm_resource_group.rg-br-infra-prod.location 
   resource_group_name  =   azurerm_resource_group.rg-br-infra-prod.name
   allocation_method    =   "Static" 
   sku                 = "Standard"
   tags     = {
         "environment" = "prod"
         "project"  = "server"
    }
} 

#Criacao de interface de rede privada da vm-01-wireguard-gw-hub
resource "azurerm_network_interface" "inet-01-vm-01-wireguard-gw-hub" {
    name                      = "inet-01-vm-01-wireguard-gw-hub"
    location                  = azurerm_resource_group.rg-br-infra-prod.location
    resource_group_name       = azurerm_resource_group.rg-br-infra-prod.name
    enable_ip_forwarding = true 
 
  ip_configuration{
    name                          = "pip-vm-01-wireguard-gw-hub"
    public_ip_address_id          = azurerm_public_ip.pip-ip-vm-wirequard-gw-hub.id
    private_ip_address_allocation = "static"
    private_ip_address            = "172.25.0.5" 
    subnet_id                     = azurerm_subnet.subnet-grupo-hub-prod.id
  }

  tags     = {
         "environment" = "prod"         
     }
}

#Criacao de interface de rede privada da vm-01-linux-server
# resource "azurerm_network_interface" "inet-01-vm-01-linux-server" {
#     name                      = "inet-01-vm-01-linux-server"
#     location                  = azurerm_resource_group.rg-br-infra-prod.location
#     resource_group_name       = azurerm_resource_group.rg-br-infra-prod.name
#     enable_ip_forwarding = true 
 
#   ip_configuration{
#     name                          = "pip-vm-01-linux-server"
#     #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-wirequard-gw-hub.id
#     private_ip_address_allocation = "static"
#     private_ip_address            = "172.26.1.6" 
#     subnet_id                     = azurerm_subnet.subnet-grupo-server-prod.id
#   }

#   tags     = {
#          "environment" = "prod"         
#      }
# }


#serverR4-apoio
#Criacao de interface de rede privada da vm-03-server-01
resource "azurerm_network_interface" "inet-01-vm-07-server-04" {
  name                = "inet-01-vm-07-server-04"
  location            = azurerm_resource_group.rg-br-server-prd.location
  resource_group_name = azurerm_resource_group.rg-br-server-prd.name

  #dns_servers = ["172.20.2.10"]

  ip_configuration {
    name                          = "internal"    
    subnet_id                     = azurerm_subnet.subnet-grupo-server-app-prod.id ###
    #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-server1.id
    private_ip_address_allocation = "static"   
    private_ip_address              = "172.20.1.12" 
  }
  tags     = {
         "environment" = "prod"
         "project"  = "server"
     }
}

#serverR4-apoio
#Criacao de interface de rede privada da vm-03-server-01
resource "azurerm_network_interface" "inet-01-vm-08-domain-01" {
  name                = "inet-01-vm-08-domain-01"
  location            = azurerm_resource_group.rg-br-server-prd.location
  resource_group_name = azurerm_resource_group.rg-br-server-prd.name

  #dns_servers = ["172.20.2.10"]

  ip_configuration {
    name                          = "internal"    
    subnet_id                     = azurerm_subnet.subnet-grupo-hub-app-prod.id ###
    #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-server1.id
    private_ip_address_allocation = "static"   
    private_ip_address              = "172.25.1.10" 
  }
  tags     = {
         "environment" = "prod"
         "project"  = "server"
     }
}

# resource "azurerm_network_interface" "inet-02-vm-08-domain-01" {
#   name                = "inet-02-vm-08-domain-01"
#   location            = azurerm_resource_group.rg-br-server-prd.location
#   resource_group_name = azurerm_resource_group.rg-br-server-prd.name

#   #dns_servers = ["172.20.2.10"]

#   ip_configuration {
#     name                          = "internal"    
#     subnet_id                     = azurerm_subnet.subnet-grupo-hub-prod.id ###
#     #public_ip_address_id          = azurerm_public_ip.pip-ip-vm-server1.id
#     private_ip_address_allocation = "static"   
#     private_ip_address              = "172.25.0.11" 
#   }
#   tags     = {
#          "environment" = "prod"
#          "project"  = "server"
#      }
# }

#terraform import azurerm_bastion_host.vnet-grupo-spoke-prod-bastion
#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/bastionHosts/vnet-grupo-spoke-prod-bastion

resource "azurerm_bastion_host" "vnet-grupo-spoke-prod-bastion" {
    #dns_name            = "bst-a12bc660-9066-4d9c-9b31-6d806513ef5e.bastion.azure.com"
    #id                  = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/bastionHosts/vnet-grupo-spoke-prod-bastion"
    location            = "brazilsouth"
    name                = "vnet-grupo-spoke-prod-bastion"
    resource_group_name = "rg-br-infra-prod"
    tags                = {
        "environment" = "prod"
    }

    ip_configuration {
        name                 = "IpConf"
        public_ip_address_id = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/publicIPAddresses/vnet-grupo-spoke-prod-ip"
        subnet_id            = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/virtualNetworks/vnet-grupo-spoke-prod/subnets/AzureBastionSubnet"
    }

    timeouts {}
}

#/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/publicIPAddresses/pip-ip-bastiao-host-prod
# resource "azurerm_public_ip" "pip-ip-bastiao-host-prod" {
#     allocation_method       = "Static"
#     #id                      = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-server-prd/providers/Microsoft.Network/publicIPAddresses/pip-ip-bastiao-host-prod"
#     idle_timeout_in_minutes = 4
#     #ip_address              = "191.234.177.22"
#     ip_version              = "IPv4"
#     location                = "brazilsouth"
#     name                    = "pip-ip-bastiao-host-prod"
#     resource_group_name     = "rg-br-server-prd"
#     sku                     = "Standard"
#     tags                    = {
#         "environment" = "prod"
#     }
#     zones                   = []

#     timeouts {}
# }

resource "azurerm_public_ip" "vnet-grupo-spoke-prod-ip"  {
    allocation_method       = "Static"
    #id                      = "/subscriptions/62dd8c87-eec5-4af3-996f-dd32e86d887c/resourceGroups/rg-br-infra-prod/providers/Microsoft.Network/publicIPAddresses/vnet-grupo-spoke-prod-ip"
    idle_timeout_in_minutes = 4
    #ip_address              = "191.237.201.41"
    ip_version              = "IPv4"
    location                = "brazilsouth"
    name                    = "vnet-grupo-spoke-prod-ip"
    resource_group_name     = "rg-br-infra-prod"
    sku                     = "Standard"
    tags                    = {
        "environment" = "prod"
    }
    zones                   = []

    timeouts {}
}



