vsphere_template  = "TMP-Win2019_Packer_2022_04"
vsphere_datastore = ["XN_iSCSI_SSD", "XN_iSCSI_SSD", "XN_iSCSI_SSD2", "XN_iSCSI_SSD2"]
vsphere_network   = ["Lab-LAN1", "Lab-LAN1", "Lab-LAN2", "Lab-LAN2"]
vm_folder         = "HomeLab/Windows"
vm_name           = ["HL-TestCLUS-1", "HL-TestCLUS-2", "HL-TestCLUS-R1", "HL-TestCLUS-R2"]
ip_address        = ["10.10.0.53", "10.10.0.54", "10.20.0.53", "10.20.0.54"]
ip_gateway        = ["10.10.0.1", "10.10.0.1", "10.20.0.1", "10.20.0.1"]
vm_ram            = 4096
vm_cpu            = 2

