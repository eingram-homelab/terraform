# This file contains the Terraform variables for the staging environment.
github_owner = "eingram-homelab"

repos = {
  "stg-repo" = {
    visibility                      = "public"
    default_branch                  = "main"
    required_approving_review_count = 0
  }
  "stg-repo-2" = {
    visibility                      = "public"
    default_branch                  = "main"
    required_approving_review_count = 0
  }
}
