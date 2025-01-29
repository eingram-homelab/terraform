terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 3.0"
    }
  }
}

# Configure the Rancher2 provider
provider "rancher2" {
  api_url    = var.rancher_api_url
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
  insecure   = var.rancher_insecure # Set to true if using self-signed certificates
}

resource "rancher2_cloud_credential" "vsphere" {
  name = var.vsphere_cloud_credential_name
  vsphere_credential_config {
    password = var.vsphere_password
    username = var.vsphere_username
    vcenter = var.vsphere_vcenter
  }
}

# Create vsphere machine config v2
resource "rancher2_machine_config_v2" "cp_config" {
    generate_name = "cp"
    vsphere_config {
        clone_from = var.vsphere_template
        creation_type = "template"
        cpu_count   = var.control_plane_cpu
        memory_size = var.control_plane_memory
        disk_size   = var.control_plane_disk_size
        datacenter  = var.vsphere_datacenter
        datastore   = var.vsphere_datastore
        folder      = var.vsphere_folder
        network     = var.vsphere_network
        pool        = var.vsphere_resource_pool
        tags        = var.vsphere_tags
    }
}

# Create worker machine config v2
resource "rancher2_machine_config_v2" "worker_config" {
    generate_name = "worker"
    vsphere_config {
        clone_from = var.vsphere_template
        creation_type = "template"
        cpu_count   = var.worker_cpu
        memory_size = var.worker_memory
        disk_size = var.worker_disk_size
        datacenter  = var.vsphere_datacenter
        datastore   = var.vsphere_datastore
        folder      = var.vsphere_folder
        network     = var.vsphere_network
        pool        = var.vsphere_resource_pool
    }
}

# Create a new rancher v2 RKE2 Custom Cluster
resource "rancher2_cluster_v2" "cluster" {
  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version
  enable_network_policy = false
  
  # RKE2/K3s cluster config
  rke_config {
    machine_global_config = yamlencode({
      "disable" = length(var.disabled_features) > 0 ? var.disabled_features : []
      # cni = var.cluster_cni
      enable-controller-manager-metrics = true  
      etcd-expose-metrics            = true

    })

    # registries {
    #   system_default_registry = "docker.io"
    # }

    machine_pools {
      name                         = "control-plane"
      cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
      control_plane_role          = true
      etcd_role                   = true
      worker_role                 = var.worker_node_count > 0 ? false : true
      quantity                    = var.control_plane_node_count
      drain_before_delete = true

      machine_config {
        kind = rancher2_machine_config_v2.cp_config.kind
        name = rancher2_machine_config_v2.cp_config.name
      }
    }

    dynamic "machine_pools" {
      for_each = var.worker_node_count > 0 ? [1] : []
      content {
        name                         = "worker"
        cloud_credential_secret_name = rancher2_cloud_credential.vsphere.id
        control_plane_role          = false
        etcd_role                   = false
        worker_role                 = true
        quantity                    = var.worker_node_count
        drain_before_delete = true

        machine_config {
          kind = rancher2_machine_config_v2.worker_config.kind
          name = rancher2_machine_config_v2.worker_config.name
        }
      }
    }
    # machine_pools {
    #   name                         = "worker"
    #   cloud_credential_secret_name = var.vsphere_cloud_credential_name
    #   control_plane_role          = false
    #   etcd_role                   = false
    #   worker_role                 = true
    #   quantity                    = var.worker_node_count

    #   machine_config {
    #     kind = rancher2_machine_config_v2.worker_config.kind
    #     name = rancher2_machine_config_v2.worker_config.name
    #   }
    # }
  }
}

# Output the cluster ID and kube_config
output "cluster_id" {
  value = rancher2_cluster_v2.cluster.id
}

output "kube_config" {
  value     = rancher2_cluster_v2.cluster.kube_config
  sensitive = true
}
