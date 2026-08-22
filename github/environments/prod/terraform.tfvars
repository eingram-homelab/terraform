# This file contains the Terraform variables for the production environment.
github_owner = "eingram-homelab"

repos = {
  "prod-repo" = {
    visibility                      = "public"
    default_branch                  = "main"
    required_approving_review_count = 0
  }
  "prod-repo-2" = {
    visibility                      = "public"
    default_branch                  = "main"
    required_approving_review_count = 0
  }
}
