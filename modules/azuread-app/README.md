# Azure App Registration

This Terraform module creates and manages Azure AD app registrations.

## Files

- `provider.tf` - Azure AD provider configuration
- `versions.tf` - Terraform and provider version constraints
- `variables.tf` - Input variables for the module
- `main.tf` - Azure app registration resources
- `outputs.tf` - Output values (app ID, object ID, etc.)
- `terraform.tfvars.example` - Example variable values

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your desired values:
   ```hcl
   app_name        = "my-app-registration"
   app_description = "My application registration"
   owners          = ["<owner-object-id>"]
   tags = {
     environment = "prod"
   }
   ```

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Key Resources

- `azuread_application` - The app registration
- `azuread_service_principal` - The service principal for the app
- `azuread_application_password` - Client secret (optional, commented out)
- `azuread_app_role_assignment` - API permissions (optional, commented out)

## Customization

Uncomment and configure the following as needed:

- **Web configuration**: Redirect URIs for OAuth flows
- **API configuration**: Access token version
- **Required resource access**: API permissions needed
- **Client secret**: If you need an authentication secret
- **App role assignments**: If you need to grant permissions

## Outputs

- `application_id` - The application/client ID
- `object_id` - The object ID of the app registration
- `service_principal_id` - The service principal ID
- `client_secret` - The secret value (if created)

## References

- [Terraform AzureAD Provider Documentation](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs)
- [Azure App Registration Documentation](https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app)
