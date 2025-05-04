# Output the cluster name, ID and kube_config

output "cluster_name" {
  description = "Cluster Name"
  value       = module.rancher.cluster_name
}

output "cluster_id" {
  description = "Cluster ID"
  value       = module.rancher.cluster_id
}

# output "cluster_kube_config" {
#   description = "Kube Config"
#   value       = module.rancher.cluster_kube_config
#   sensitive   = true
# }
