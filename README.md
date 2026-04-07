
# Terraform

Infrastructure-as-code for automating VM provisioning and Kubernetes cluster management using Terraform.

## Structure

```
projects/      Environment-specific deployments
```


## Projects

| Project | Description |
|---|---|
| `projects/rancher/k3s-clus1` | Production k3s cluster (k3s-clus1) via Rancher on vSphere |
| `projects/rancher/k3s-clus1-dev` | Dev k3s cluster via Rancher on vSphere |
| `projects/vsphere/linux-k3s-mgmt` | k3s management node VMs on vSphere |
| `projects/vsphere/linux-rancher` | Rancher server VM on vSphere |
| `projects/vsphere/linux-podhost-dmz` | DMZ pod host VMs on vSphere |
| `projects/vsphere/linux-test` | Test VMs on vSphere |
| `projects/vsphere-linux-k3s-mgmt` | Additional k3s mgmt node provisioning |
| `projects/cicd/vsphere` | CI/CD infrastructure on vSphere |
| `projects/k3d` | Local k3d cluster provisioning |

## Prerequisites

- Terraform >= 1.0
- HashiCorp Vault (secrets backend for Rancher API tokens, vSphere credentials, SSH keys)
- GCS bucket for remote state (`yc-srv1-tfstate`)
- Access to Rancher at `https://rancher.local.lan`
- vSphere/vCenter access

## Usage

```bash
cd projects/<project>
terraform init
terraform plan
terraform apply
```

Secrets are pulled from Vault at plan/apply time — ensure `vault login` is current before running.

