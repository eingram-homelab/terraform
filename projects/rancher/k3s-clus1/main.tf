# Edit this line to trigger build

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

data "vault_generic_secret" "salt_password" {
  path = "secret/ssh/eingram"
}

data "vault_generic_secret" "ssh_pub_key" {
  path = "secret/ssh/eingram"
}

module "rancher" {
  source                        = "../../../modules/rancher"
  rancher_api_url               = "https://rancher.local.lan"
  rancher_access_key            = data.vault_generic_secret.token.data["token"]
  rancher_secret_key            = data.vault_generic_secret.secret.data["secret"]
  cluster_name                  = "k3s-clus1"
  kubernetes_version            = "v1.31.4+k3s1"
  vsphere_vcenter               = "vcsa-1.local.lan"
  vsphere_username              = "administrator@vsphere.local"
  vsphere_password              = data.vault_generic_secret.vsphere_password.data["vsphere_password"]
  vsphere_datacenter            = "/HomeLab Datacenter"
  vsphere_datastore             = "/HomeLab Datacenter/datastore/vsanDatastore"
  vsphere_folder                = "/HomeLab Datacenter/vm/Rancher"
  vsphere_network               = ["/HomeLab Datacenter/network/DPG-Lab-LAN1"]
  vsphere_resource_pool         = "/HomeLab Datacenter/host/Intel NUC10 Cluster/Resources/Rancher"
  control_plane_node_count      = 1
  worker_node_count             = 2
  control_plane_cpu             = 4
  control_plane_memory          = 8196
  control_plane_disk_size       = 102400
  worker_cpu                    = 2
  worker_memory                 = 4096
  worker_disk_size              = 102400
  vsphere_template              = "/HomeLab Datacenter/vm/Templates/TMP-Rocky9_Packer_RKE2"
  rancher_insecure              = true
  vsphere_cloud_credential_name = "vsphere"
  # cluster_cni = "flannel"
  disabled_features     = ["servicelb", "traefik"]
  vsphere_tags          = ["prod"]
  vsphere_cfgparam      = ["disk.enableUUID=TRUE"]
  salt_password         = data.vault_generic_secret.salt_password.data["salt_password"]
  ssh_key               = data.vault_generic_secret.ssh_pub_key.data["ssh_pub_key"]
  tls_san               = ["k3s-clus1.local.lan", "10.10.0.207"]
  serialize_image_pulls = true
  kubelet_args           = ["cloud-provider=external",
                            "container-log-max-files=4",
                            "container-log-max-size=50Mi",
                            "image-gc-high-threshold=50",
                            "image-gc-low-threshold=40",
                            "system-reserved=cpu=250m,memory=256Mi,ephemeral-storage=1Gi",
                            "kube-reserved=cpu=250m,memory=256Mi,ephemeral-storage=1Gi",
                            "eviction-hard=memory.available<100Mi,nodefs.available<10%,imagefs.available<15%",
                            "eviction-soft=memory.available<200Mi,nodefs.available<15%,imagefs.available<20%",
                            "eviction-soft-grace-period=memory.available=1m30s,nodefs.available=1m30s,imagefs.available=1m30s"
                          ]
  kube_apiserver_args     = ["max-requests-inflight=400", "max-mutating-requests-inflight=200", "min-request-timeout=300"]
  etcd_args               = ["auto-compaction-mode=periodic", "auto-compaction-retention=1h", "snapshot-count=5000", "quota-backend-bytes=2147483648"]
}
