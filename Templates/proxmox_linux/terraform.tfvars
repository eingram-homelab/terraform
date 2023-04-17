proxmox_template  = "Rocky9-TMP"
storage = "zpool0"

vlan = 200

vm_name_list = [
  "Test2"
]

ip_address_list = [
  "10.10.0.94",
  # "10.10.0.81",
  # "10.10.0.82"
]

ip_gateway_list    = [
  "10.10.0.1"
]

vm_ram        = 1024
vm_cores        = 1
disk_size = "60G"

# vm_disks_list = [
#   { 
#     label = "longhorn1",
    # id = 1,
#     size = 60,
#     thin_provisioned = true,
#   }
# ]
