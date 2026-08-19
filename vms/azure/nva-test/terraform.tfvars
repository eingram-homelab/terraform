vm_name             = "nva-test-01"
resource_group_name = "HomeLabRG"
location            = "westus"
vm_size             = "Standard_B1ls"
vnet_name           = "vnet-test-01"
subnet_name         = "snet-test-01"
admin_username      = "azureadmin"
public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwwvtM55JcbHVFcpq6uJAZ5qZj4z1FI0fYzTwLOm7Xef9kCYKtwBqNH/ixWfYbeM3qKfwP3JrdldEVi5cJauWt8YzHnAAeBcKkHJk47rI26P+DuLfnfnrX5PkIkwX7dUl4C/4ShJNsgTquI9xdwGWHwGpp9NZNTx+Z02A7/ANpCVjGYqDAahlhXYXAr3wEJ7wZucGgbNF8Ru/vlhqdYBXPKxcTW+rIT+wt6D+48bmmwWRZw7W06EBPYSArpiNuonT4ChFb8Zz8ZcFpAde71ya12GjPnroH3Fq53+3t+CTINcMEJPjiOBUy+q61L7QpCVKW9LLhqpxsInUKtZjPDdP080htSPDstoHEDGqqdPWrszfazIwEJZkoLp6eMnEWztB+DNNGuZT4l/tGs6uSL9tuUjuitLSO5zPxrY2fPJm4iZrx294UrmPooUm3LNojlgZ96N9FxPxx1DBg8x6PJgRF24RmHh1oAwBToFn8BwIfjdCe728b1qsxH/LUCKiZrnc= edwardingram@Edwards-MBP.local.lan"

# Optional cloud-init
cloud_init = <<-EOT
#cloud-config
package_update: true
packages:
  - inetutils-traceroute
EOT

# Set to true to create vnet_name/subnet_name instead of using existing network resources.
create_vnet             = true
vnet_address_space      = ["10.100.0.0/16"]
subnet_address_prefixes = ["10.100.1.0/24"]

# Optional overrides.
network_interface_name       = null
private_ip_address           = null
os_disk_storage_account_type = "Standard_LRS"

tags = {
  environment = "dev"
  # owner       = "platform"
}

image = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
  version   = "latest"
}

# Enable agents
enable_waagent_extension       = true
enable_monitor_agent_extension = true