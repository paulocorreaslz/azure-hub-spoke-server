########################################
#                                      #
#           Resource Groups            #  
#                                      #
########################################



resource "azurerm_resource_group" "rg-br-server-prd" {
     location = "brazilsouth"
     name     = "rg-br-server-prd"
     tags     = {
         "environment" = "prod"
         "project"  = "server"
     }

    # timeouts {}
}


resource "azurerm_resource_group" "rg-br-infra-prod" {
    
    location = "brazilsouth"
    name     = "rg-br-infra-prod"
    tags     = {
        "environment" = "prod"
        "project"     = "infra"
    }

    timeouts {}
}