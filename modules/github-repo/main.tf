resource "github_repository" "repo" {
  allow_auto_merge       = false
  allow_merge_commit     = true
  allow_rebase_merge     = true
  allow_squash_merge     = true
  allow_update_branch    = false
  auto_init              = true
  delete_branch_on_merge = true
  name                   = var.repo_name
  visibility             = var.repo_visibility
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "disabled"
    }
  }
}

resource "github_branch_default" "default" {
  repository = github_repository.repo.name
  branch     = var.default_branch
}

resource "github_repository_ruleset" "default_branch" {
  name        = "Branch rules"
  repository  = github_repository.repo.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      exclude = []
      include = ["refs/heads/${var.default_branch}"]
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      required_approving_review_count   = var.required_approving_review_count
      dismiss_stale_reviews_on_push     = false
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_review_thread_resolution = false
    }
  }
}

resource "github_repository_vulnerability_alerts" "alert" {
  repository = github_repository.repo.name
  enabled    = true
}

resource "null_resource" "disable_external_pr" {
  triggers = {
    repo_name = github_repository.repo.name
  }

  provisioner "local-exec" {
    command = <<EOT
      gh api --method PATCH "/repos/${var.github_owner}/${var.repo_name}" \
        -f "pull_request_creation_policy=collaborators_only"
    EOT
  }

  depends_on = [github_repository.repo]
}
