##########################
#                        #
#     provedor azure     #  
#                        #
##########################

provider   "azurerm"   { 
  #  version = "~>2.13.0" 
  features   {} 
  skip_provider_registration = true
 }
