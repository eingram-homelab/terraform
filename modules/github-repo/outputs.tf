output "repo_name" {
  description = "The name of the GitHub repository."
  value       = { for name, repo in var.repos : name => github_repository.repo[name].name }
}

output "default_branch" {
  description = "The default branch of the GitHub repository."
  value       = { for name, repo in var.repos : name => github_branch_default.default[name].branch }
}

output "github_owner" {
  description = "The owner of the GitHub repository."
  value       = var.github_owner
}
