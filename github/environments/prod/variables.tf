variable "github_owner" {
  description = "The owner of the GitHub repository."
  type        = string
}

variable "repos" {
  description = "A map of GitHub repositories and their settings."
  type = map(object({
    visibility                      = string
    default_branch                  = string
    required_approving_review_count = number
    template_owner                  = optional(string, "")
    template_repo                   = optional(string, "")
  }))
}
