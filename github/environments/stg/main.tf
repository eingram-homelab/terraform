data "vault_generic_secret" "terraform" {
  path = "secret/github/pat"
}

module "github-repo" {
  source       = "../../../modules/github-repo"
  github_owner = var.github_owner
  repos        = var.repos
}
