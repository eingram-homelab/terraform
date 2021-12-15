vsphere_server = "vcsa.local.lan"
vsphere_datacenter = "HomeLab Datacenter"
vsphere_compute_cluster = "Intel NUC10 Cluster"
vm_name = "docker1" # Change this
vsphere_datastore = "XN_iSCSI_SSD2"
vm_folder = "Docker"
vsphere_network = "Lab-LAN1"
vsphere_template = "TMP-Centos7_Packer_2021_11"
ansible_group = "centos" # Change this

ip_address = "10.10.0.29" # Change this

dns_server_list = [
    "192.168.1.250",
    "192.168.1.251"
]
dns_suffix_list = [
    "local.lan"
]