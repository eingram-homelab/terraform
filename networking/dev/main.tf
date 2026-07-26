module "azure-network" {
  source = "../../modules/azure-vnet"

  resource_group_name = "rg-network-dev"
  location            = "West US"
  nsg_name            = "nsg-dev"
  ssh_source_address  = "*"
  vnet_name           = "vnet-dev"
  vnet_address_space  = ["10.100.1.0/24"]
}
