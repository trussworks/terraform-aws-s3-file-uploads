#
# S3 Bucket for File Upload
#
module "file_uploads_s3_bucket" {
  source         = "trussworks/s3-private-bucket/aws"
  version        = "~>3.5.0"
  bucket         = var.file_uploads_bucket
  logging_bucket = var.create_logging_bucket ? module.file_uploads_s3_logging_bucket.aws_logs_bucket : local.file_uploads_s3_bucket_logs

  cors_rules = var.cors_rules

  tags = {
    Name        = "S3 bucket for file uploads"
    Environment = var.environment
    Automation  = "Terraform"
  }
}

module "file_uploads_s3_logging_bucket" {
  count   = var.create_logging_bucket ? 1 : 0
  source  = "trussworks/logs/aws"
  version = "~> 10.3.0"

  s3_bucket_name          = local.file_uploads_s3_bucket_logs
  s3_log_bucket_retention = var.s3_logs_retention_days

  default_allow = false

  tags = {
    Name        = "S3 bucket for logs relating to file uploads"
    Environment = var.environment
    Automation  = "Terraform"

  }
}

