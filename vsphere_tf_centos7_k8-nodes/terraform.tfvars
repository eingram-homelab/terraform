vsphere_server = "vcsa.local.lan"
vsphere_datacenter = "HomeLab Datacenter"
vsphere_compute_cluster = "Intel NUC10 Cluster"
vm_name = "k8-node" # Change this
vsphere_datastore = "XN_iSCSI_SSD2"
vm_folder = "k8s" # Change this
vsphere_network = "Lab-LAN1"
vsphere_template = "TMP-Centos7_Packer_2021_11"
ansible_group = "k8s" # Change this

ip_address_list = [
    "10.10.0.26",
    "10.10.0.27",
    "10.10.0.28"
]
dns_server_list = [
    "192.168.1.250",
    "192.168.1.251"
]
dns_suffix_list = [
    "local.lan"
]