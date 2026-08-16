output "repo_name" {
  description = "The name of the GitHub repository."
  value       = github_repository.repo.name
}

output "default_branch" {
  description = "The default branch of the GitHub repository."
  value       = github_branch_default.default.branch
}

output "github_owner" {
  description = "The owner of the GitHub repository."
  value       = var.github_owner
}
