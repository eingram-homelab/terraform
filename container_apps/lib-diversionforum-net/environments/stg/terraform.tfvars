app_name = "lib-diversionforum-net-stg"
resource_group_name           = "lib-diversionforum-net-stg"
location                      = "West US"

vnet_address_space            = ["10.0.0.0/16"]
dns_servers                   = ["10.0.0.4", "10.0.0.5"]
subnets = {
  container_subnet = {
    address_prefixes = ["10.0.1.0/24"]
  }
}

security_rules = {
  AllowHTTPHTTPS = {
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

container_app_environment = {
  workload_profile_name        = "Consumption"
  workload_profile_type        = "Consumption"
  public_network_access        = "Enabled"
  internal_load_balancer_enabled = false
}

container_app = {
  image                        = "nginx:latest"
  cpu                          = "0.5"
  memory                       = "1Gi"
  revision_mode                = "Single"
  max_replicas                 = 1
  min_replicas                 = 0
  cooldown_period_in_seconds   = 300
  polling_interval_in_seconds  = 30
  ingress = {
    external_enabled           = true
    target_port                = 80
    allow_insecure_connections = true
  }
}

tags = {
  environment = "staging"
  project     = "lib-diversionforum-net"
}
