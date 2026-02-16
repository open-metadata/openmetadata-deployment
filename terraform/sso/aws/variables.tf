variable "region" {
  type        = string
  description = "Region for AWS Cognito User Pool"
  default     = "us-east-1"
}

variable "user_pool_name" {
  type        = string
  description = "Name for the Cognito user pool"
  default     = "OMD Pool"
}

variable "user_pool_alias_attributes" {
  type        = list(string)
  description = "Attributes supported as an alias for the user pool"
  default     = ["email"]
}

variable "from_email_address" {
  type        = string
  description = "Sender's email address or sender's display name with their email address"
  default     = "no-reply@verificationemail.com"
}

variable "user_pool_domain" {
  type        = string
  description = "Domain for user pool"
  default     = "openmetadata"
}

variable "user_pool_client_name" {
  type        = string
  description = "Name of the application client"
  default     = "app-OMD"
}

variable "client_callback_urls" {
  type        = list(string)
  description = "List of allowed callback URLs for the identity provider"
  default     = ["http://localhost:8585/callback"]
}