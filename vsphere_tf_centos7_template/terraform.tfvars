vsphere_server = "vcsa.local.lan"
vsphere_datacenter = "HomeLab Datacenter"
vsphere_compute_cluster = "Intel NUC10 Cluster"
vm_name = "Test"
vsphere_datastore = "XN_iSCSI_SSD2"
vm_folder = "Terraform Provisioned"
vsphere_network = "Lab-LAN1"
vsphere_template = "TMP-Centos7_Packer_2021_11"

ip_address_list = [
    "10.10.0.25",
    # "10.10.0.81",
    # "10.10.0.82"
]
dns_server_list = [
    "192.168.1.250",
    "192.168.1.251"
]
dns_suffix_list = [
    "local.lan"
]