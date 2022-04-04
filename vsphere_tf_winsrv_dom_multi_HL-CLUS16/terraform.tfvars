vsphere_template = "TMP-Win2016_Packer_2022_02"
vsphere_datastore = ["XN_iSCSI_SSD","XN_iSCSI_SSD","XN_iSCSI_SSD2","XN_iSCSI_SSD2"]
vsphere_network = ["Lab-LAN1","Lab-LAN1","Lab-LAN2","Lab-LAN2"]
vm_folder = "HomeLab/Windows"
vm_name = ["HL-CLUS16-1","HL-CLUS16-2","HL-CLUS16-R1","HL-CLUS16-R2"] 
ip_address = ["10.10.0.41","10.10.0.42","10.20.0.41","10.20.0.42"] 
ip_gateway = ["10.10.0.1","10.10.0.1","10.20.0.1","10.20.0.1"]
vm_ram = 4096
vm_cpu = 2

