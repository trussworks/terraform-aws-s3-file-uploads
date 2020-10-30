#
# S3 Bucket for File Upload
#
module "file_uploads_s3_bucket" {
  source         = "trussworks/s3-private-bucket/aws"
  version        = "~>2.1.0"
  bucket         = var.file_uploads_bucket
  logging_bucket = module.file_uploads_s3_logging_bucket.aws_logs_bucket

  cors_rules = var.cors_rules

  tags = {
    Name        = "S3 bucket for file uploads"
    Environment = var.environment
    Automation  = "Terraform"
  }
}

locals {
  file_uploads_s3_bucket_logs = "${var.application_name}-${var.environment}-${var.file_uploads_s3_bucket}-logs"
}

# we use a separate access logging bucket for every environment
module "file_uploads_s3_logging_bucket" {
  source  = "trussworks/logs/aws"
  version = "~> 8.0.0"
  region  = var.region

  s3_bucket_name = local.file_uploads_s3_bucket_logs

  default_allow = false

  tags = {
    Name        = "S3 bucket for logs relating to file uploads"
    Environment = var.environment
    Automation  = "Terraform"

  }
}
