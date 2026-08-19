variable "scope" {
  description = "The scope at which the role assignment applies. If not provided, defaults to the resource group."
  type        = string
  default     = null
}

variable "role_definition_name" {
  description = "The name of the role definition to assign."
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID where the role assignment applies."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name where the role assignment applies."
  type        = string
}

variable "principal_id" {
  description = "The object ID of the principal to assign the role to."
  type        = string
}
