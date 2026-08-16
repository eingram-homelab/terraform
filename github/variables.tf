variable "github_owner" {
  description = "The owner of the GitHub repository."
  type        = string
}

variable "repo_name" {
  description = "The name of the GitHub repository."
  type        = string
}

variable "repo_visibility" {
  description = "The visibility of the GitHub repository (public, private, or internal)."
  type        = string
  default     = "private"
}

variable "default_branch" {
  description = "The default branch of the GitHub repository."
  type        = string
  default     = "main"
}

variable "required_approving_review_count" {
  description = "The number of required approving reviews for pull requests."
  type        = number
  default     = 0
}
