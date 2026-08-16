terraform {
  required_version = ">= 1.5.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "vault" {
  # Configuration options
}

data "vault_generic_secret" "terraform" {
  path = "secret/github/pat"
}

provider "github" {
  owner = var.github_owner
  token = data.vault_generic_secret.terraform.data["terraform"]
}

module "github-repo" {
  source = "../modules/github-repo"

  repo_name                       = var.repo_name
  repo_visibility                 = var.repo_visibility
  default_branch                  = var.default_branch
  required_approving_review_count = var.required_approving_review_count
  github_owner                    = var.github_owner
}
