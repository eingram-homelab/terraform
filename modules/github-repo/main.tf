resource "github_repository" "repo" {
  for_each               = tomap(var.repos)
  allow_auto_merge       = false
  allow_merge_commit     = true
  allow_rebase_merge     = true
  allow_squash_merge     = true
  allow_update_branch    = false
  auto_init              = true
  delete_branch_on_merge = true
  name                   = each.key
  visibility             = each.value.visibility
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "disabled"
    }
  }
  dynamic "template" {
    for_each = each.value.template_owner != "" && each.value.template_repo != "" ? [1] : []
    content {
      owner      = each.value.template_owner
      repository = each.value.template_repo
    }
  }
}

resource "github_branch_default" "default" {
  for_each   = tomap(var.repos)
  repository = github_repository.repo[each.key].name
  branch     = each.value.default_branch
}

resource "github_repository_ruleset" "default_branch" {
  for_each    = tomap(var.repos)
  name        = "Branch rules"
  repository  = github_repository.repo[each.key].name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      exclude = []
      include = ["refs/heads/${each.value.default_branch}"]
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      required_approving_review_count   = each.value.required_approving_review_count
      dismiss_stale_reviews_on_push     = false
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_review_thread_resolution = false
    }
  }
}

resource "github_repository_vulnerability_alerts" "alert" {
  for_each   = tomap(var.repos)
  repository = github_repository.repo[each.key].name
  enabled    = true
}

resource "null_resource" "disable_external_pr" {
  for_each = tomap(var.repos)
  triggers = {
    repo_name = github_repository.repo[each.key].name
  }

  provisioner "local-exec" {
    command = <<EOT
      gh api --method PATCH "/repos/${var.github_owner}/${github_repository.repo[each.key].name}" \
        -f "pull_request_creation_policy=collaborators_only"
    EOT
  }

  depends_on = [github_repository.repo]
}
