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

variable "virus_scanning_bucket" {
  type        = string
  description = "The name of the S3 bucket used to store virus scanning tools."
}

variable "lambda_s3_bucket" {
  type        = string
  description = "The name of the S3 bucket where the lambda build artifact is stored"
}

variable "av_status_sns_arn" {
  type        = string
  description = "SNS topic ARN to publish scan results to"
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
