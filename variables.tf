variable "environment" {
  type        = string
  description = "Environment level."
  default     = "dev"
}

variable "application_name" {
  type        = string
  description = "The name of the application"
}

variable "region" {
  type        = string
  description = "Application region."
  default     = "us-west-2"
}

variable "file_uploads_bucket" {
  type        = string
  description = "The name of the S3 bucket used to store the uploads."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "cors_rules" {
  description = "List of maps containing rules for Cross-Origin Resource Sharing."
  type        = list(any)
  default     = []
}

variable "jwt_auth_issuer" {
  description = "The url to the jwt issuer to verify authorization to the lambda"
  type        = string
}

variable "jwt_auth_audience" {
  description = "The jwt audience used to verify authorization to the lambda"
  type        = string
}
