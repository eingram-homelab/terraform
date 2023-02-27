vsphere_template = "TMP-Win2022Core_Packer"
vsphere_datastore_list = [
  "XN_iSCSI_SSD2",
  # "XN_iSCSI_SSD2",
  # "XN_iSCSI_SSD2"
]

vsphere_storage_policy = "vSAN - No Fault Tolerance"

vsphere_network_list   = [
  "Lab-LAN1"
]
vm_name_list = [
  "Test"
]

ip_address_list = [
  "10.10.0.94",
  # "10.10.0.81",
  # "10.10.0.82"
]

dns_suffix_list = [
  "homelab.local",
  # "10.10.0.81",
  # "10.10.0.82"
]

ip_gateway_list    = [
  "10.10.0.1",
  # "10.10.0.1",
  # "10.10.0.1"
]

vm_ram        = 1024
vm_cpu        = 1
vm_efi_secure = false

# vm_disks_list = [
#   { 
#     label = "longhorn1",
    # id = 2,
#     size = 60,
#     thin_provisioned = true,
#   }
# ]