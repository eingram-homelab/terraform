vsphere_server = "vcsa.local.lan"
vsphere_datacenter = "HomeLab Datacenter"
vsphere_compute_cluster = "Intel NUC10 Cluster"

vsphere_template = "TMP-RHEL85_Packer_2022_01"

dns_server_list = [
    "192.168.1.250",
    "192.168.1.251"
]
dns_suffix_list = [
    "local.lan"
]

# Modify as needed

vsphere_datastore = "XN_iSCSI_SSD2"
vsphere_network = "LAN"
vm_folder = "Docker"
ansible_group = "docker" 
vm_name = "dockhost1" 
ip_address = "192.168.1.217" 
ip_gateway = "192.168.1.1"
vm_ram = 4096
vm_cpu = 2