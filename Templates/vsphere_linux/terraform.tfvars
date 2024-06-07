# Edit this to change distro
# vsphere_template = TMP-RHEL85_Packer
vsphere_template = "TMP-Rocky9_Packer"
# vsphere_template = TMP-Rocky85_Packer
# vsphere_template = TMP-CentOS_Packer
# vsphere_template = TMP-Win2022Core_Packer
# vsphere_template = TMP-Win2016_Packer
# vsphere_template = TMP-Win2019_Packer

vm_folder_name = "Linux"
# vm_folder_name = WindowsWG
# workgroup = WORKGROUP
# vm_folder_name = WindowsHL

vm_ram = 4096
vm_cpu = 2
vm_efi_secure = false

# All lists must have same # of elements

vsphere_datastore_list = [
  "vsanDatastore",
  # XN_iSCSI_SSD2,
  # XN_iSCSI_SSD2,
]
# vsphere_storage_policy = vSAN - No Fault Tolerance
vsphere_storage_policy = "vSAN Default Storage Policy"
vsphere_network_list = [
  "DPG-Services",
  "DPG-Services",
  "DPG-Services"
]
vm_name_list = [
  "k3s1",
  "k3s2",
  "k3s3"
]
ip_address_list = [
  "10.10.0.51",
  "10.10.0.52",
  "10.10.0.53"
]
ip_gateway_list = [
  "10.10.0.1",
  "10.10.0.1",
  "10.10.0.1"
]
dns_suffix_list = [
  "local.lan",
  "local.lan",
  "local.lan"
]

# vm_disks_list = [
#   { 
#     label = "longhorn1",
    # id = 1,
#     size = 60,
#     thin_provisioned = true,
#   }
# ]
