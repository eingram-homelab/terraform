output "repo_name" {
  description = "The name of the GitHub repository."
  value       = module.github-repo.repo_name
}

output "github_owner" {
  description = "The owner of the GitHub repository."
  value       = module.github-repo.github_owner
}
