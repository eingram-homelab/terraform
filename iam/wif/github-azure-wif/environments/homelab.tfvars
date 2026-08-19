resource_group_name = "HomeLabRG"

federated_identity_credentials = {
  pull_request_plan = {
    display_name = "github-terraform-pull-request-plan"
    description  = "Terraform plans for pull requests"
    audiences    = ["api://AzureADTokenExchange"]
    issuer       = "https://token.actions.githubusercontent.com"
    subject      = "repo:eingram-homelab/terraform:pull_request"
  }

  development_apply = {
    display_name = "github-terraform-development-apply"
    description  = "Terraform applies using the development environment"
    audiences    = ["api://AzureADTokenExchange"]
    issuer       = "https://token.actions.githubusercontent.com"
    subject      = "repo:eingram-homelab/terraform:environment:development"
  }

  production_apply = {
    display_name = "github-terraform-production-apply"
    description  = "Terraform applies using the production environment"
    audiences    = ["api://AzureADTokenExchange"]
    issuer       = "https://token.actions.githubusercontent.com"
    subject      = "repo:eingram-homelab/terraform:environment:production"
  }
}
