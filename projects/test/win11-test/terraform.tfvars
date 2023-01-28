vsphere_template = "TMP-Win11_Packer"
vsphere_datastore_list = [
  "vsanDatastore",
  # "XN_iSCSI_SSD2",
  # "XN_iSCSI_SSD2"
]

vsphere_storage_policy = "vSAN - No Fault Tolerance"

vsphere_network_list   = [
  "DPG-Lab-LAN1"
]
vm_name_list = [
  "win11-test"
]

workgroup = "WORKGROUP"
vm_folder_name = "WindowsWG"

ip_address_list = [
  "10.10.0.23",
  # "10.10.0.81",
  # "10.10.0.82"
]

dns_suffix_list = [
  "local.lan",
  # "10.10.0.81",
  # "10.10.0.82"
]

ip_gateway_list    = [
  "10.10.0.1",
  # "10.10.0.1",
  # "10.10.0.1"
]

vm_ram = 4096
vm_cpu = 2
vm_efi_secure = true

# vm_disks_list = [
#   { 
#     label = "longhorn1",
    # id = 2,
#     size = 60,
#     thin_provisioned = true,
#   }
# ]