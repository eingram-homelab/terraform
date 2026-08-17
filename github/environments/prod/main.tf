data "vault_generic_secret" "terraform" {
  path = "secret/github/pat"
}

module "github-repo" {
  source = "../modules/github-repo"

  repo_name                       = var.repo_name
  repo_visibility                 = var.repo_visibility
  default_branch                  = var.default_branch
  required_approving_review_count = var.required_approving_review_count
  github_owner                    = var.github_owner
}
