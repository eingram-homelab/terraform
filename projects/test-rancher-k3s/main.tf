provider "vault" {
}

data "vault_generic_secret" "token" {
  path = "secret/rancher"
}

data "vault_generic_secret" "secret" {
  path = "secret/rancher"
}

data "vault_generic_secret" "vsphere_password" {
  path = "secret/vsphere/vcsa"
}

module "rancher" {
  source = "../../modules/rancher"
  rancher_api_url = "https://podhost-dev.local.lan:8443"
  rancher_access_key = data.vault_generic_secret.token.data["token"]
  rancher_secret_key = data.vault_generic_secret.secret.data["secret"]
  cluster_name = "test-k3s"
  kubernetes_version = "v1.29.10+k3s1"
  vsphere_vcenter = "vcsa-1.local.lan"
  vsphere_username = "administrator@vsphere.local"
  vsphere_password = data.vault_generic_secret.vsphere_password.data["vsphere_password"]
  vsphere_datacenter = "/HomeLab Datacenter"
  vsphere_datastore = "/HomeLab Datacenter/datastore/vsanDatastore"
  vsphere_folder = "/HomeLab Datacenter/vm/Rancher"
  vsphere_network = ["/HomeLab Datacenter/network/DPG-Lab-LAN1"]
  vsphere_resource_pool = "/HomeLab Datacenter/host/Intel NUC10 Cluster/Resources/Rancher"
  control_plane_node_count = 1
  worker_node_count = 0
  control_plane_cpu = 2
  control_plane_memory = 4096
  worker_cpu = 2
  worker_memory = 4096
  vsphere_template = "/HomeLab Datacenter/vm/Templates/TMP-Rocky9_Packer_RKE2"
  rancher_insecure = true
  vsphere_cloud_credential_name = "vsphere"
}
