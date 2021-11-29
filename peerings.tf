########################################
#                                      #
#             Peerings                 #  
#                                      #
########################################

# enable global peering between the two virtual network
# resource "azurerm_virtual_network_peering" "vnet-brarmazem-prod-server_to_vnet-brarmazem-server-prod" {
#     allow_forwarded_traffic      = true
#     allow_gateway_transit        = false
#     allow_virtual_network_access = true
#     
#     name                         = "vnet-brarmazem-prod-server_to_vnet-brarmazem-server-prod"
#     remote_virtual_network_id    = azurerm_virtual_network.vnet-brarmazem-server-prod.id
#     
#     resource_group_name          = azurerm_resource_group.rg-br-server-prd.name
#     use_remote_gateways          = false
#     virtual_network_name         = "vnet-brarmazem-prod-server"

#     timeouts {}
# }
