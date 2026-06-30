module "azure-network" {
  source = "../../modules/azure-vnet"

  resource_group_name = "rg-network-prod"
  location            = "West US"
  nsg_name            = "nsg-prod"
  ssh_source_address  = "*"
  vnet_name           = "vnet-prod"
  vnet_address_space  = ["10.200.1.0/24"]
}
