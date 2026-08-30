
# Terraform

Infrastructure-as-code for automation using Terraform

## Structure

```text
modules/      Shared modules
top-level-folder/     Environment based folders for infrastructure stacks (networking, compute, iam, etc)
```

## Usage

```bash
cd projects/<project>
terraform init
terraform plan
terraform apply
```

Secrets are pulled from Vault at plan/apply time — ensure `vault login` is current before running.

## Local Development Workflow

Use this workflow when building a new infrastructure stack or adding a new resource stack.

### 1. Create the stack folder structure

Create folders in this pattern:

```text
<stack>/<resource>/environments/stg
<stack>/<resource>/environments/prod
```

Example:

```text
monitoring/azure_law/environments/stg
monitoring/azure_law/environments/prod
```

### 2. Build and validate in `stg` first

Create all required Terraform files and resources in `environments/stg` first (for example: `main.tf`, `variables.tf`, `terraform.tfvars`, `providers.tf`, `backend.tf`, `outputs.tf`).

### 3. Verify local cloud access

Before running Terraform, confirm your local context is authenticated for both:

- GCP access to the remote state bucket (GCS backend)
- Azure access for resource provisioning

If authentication is missing or expired, refresh credentials before continuing.

### 4. Prove create and destroy in `stg`

From the `environments/stg` folder, run:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out tfplan
terraform apply tfplan
terraform destroy
```

The stack should successfully create and destroy resources in staging before promotion.

### 5. Lock providers for supported platforms

After staging verification, generate provider lock entries for CI and local development platforms:

```bash
terraform providers lock -platform=linux_amd64 -platform=darwin_arm64
```

Commit the generated/updated `.terraform.lock.hcl`.

## CI/CD Promotion Workflow (stg -> prod)

After `stg` is verified:

1. Copy the Terraform files (`*.tf`), variable files (`*.tfvars`), and any required HashiCorp configuration files (`*.hcl`) from `environments/stg` to `environments/prod`.
2. Update production values in `prod` (naming, sizing, SKUs, network ranges, tags, quotas, and any environment-specific settings).
3. Run `terraform fmt`, `terraform validate`, and `terraform plan` in `prod` to confirm the stack is ready.
4. Commit changes to a feature branch.
5. Open a pull request to `main` to trigger CI/CD.

Keep `stg` and `prod` structurally consistent, with differences limited to environment-specific inputs.

## Quick Command Reference

Use these commands as a starting point. Update `STACK` and `RESOURCE` for your target.

### 1. Create stack folders

```bash
STACK="monitoring"
RESOURCE="azure_law"

mkdir -p "$STACK/$RESOURCE/environments/stg"
mkdir -p "$STACK/$RESOURCE/environments/prod"
```

### 2. Validate staging lifecycle

```bash
cd "$STACK/$RESOURCE/environments/stg"

terraform init
terraform fmt -check
terraform validate
terraform plan -out tfplan
terraform apply tfplan
terraform destroy
```

### 3. Lock providers for local and CI platforms

```bash
cd "$STACK/$RESOURCE/environments/stg"
terraform providers lock -platform=linux_amd64 -platform=darwin_arm64
```

### 4. Copy stg config to prod

```bash
cp "$STACK/$RESOURCE/environments/stg"/*.{tf,tfvars,hcl} "$STACK/$RESOURCE/environments/prod/"
```

If your shell reports no matches for one of the patterns, copy files separately:

```bash
cp "$STACK/$RESOURCE/environments/stg"/*.tf "$STACK/$RESOURCE/environments/prod/"
cp "$STACK/$RESOURCE/environments/stg"/*.tfvars "$STACK/$RESOURCE/environments/prod/"
cp "$STACK/$RESOURCE/environments/stg"/*.hcl "$STACK/$RESOURCE/environments/prod/"
```

### 5. Validate prod and prepare PR

```bash
cd "$STACK/$RESOURCE/environments/prod"

terraform fmt -check
terraform validate
terraform plan

cd -
git checkout -b feat/${STACK}-${RESOURCE}-prod
git add "$STACK/$RESOURCE"
git commit -m "Add ${STACK}/${RESOURCE} stg and prod Terraform stack"
git push -u origin "feat/${STACK}-${RESOURCE}-prod"
```

Open a pull request from your feature branch to `main` to trigger CI/CD.

