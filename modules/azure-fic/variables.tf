variable "fic_application_id" {
  description = "The application ID of the Azure AD application for the federated identity credential."
  type        = string
}

variable "fic_display_name" {
  description = "The display name of the federated identity credential."
  type        = string
}

variable "fic_description" {
  description = "The description of the federated identity credential."
  type        = string
}

variable "fic_audiences" {
  description = "The audiences of the federated identity credential."
  type        = list(string)
}

variable "fic_issuer" {
  description = "The issuer of the federated identity credential."
  type        = string
}

variable "fic_subject" {
  description = "The subject of the federated identity credential."
  type        = string
}
