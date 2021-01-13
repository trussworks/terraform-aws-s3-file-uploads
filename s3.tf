#
# S3 Bucket for File Upload
#
module "file_uploads_s3_bucket" {
  source         = "trussworks/s3-private-bucket/aws"
  version        = "~>3.2.0"
  bucket         = var.file_uploads_bucket
  logging_bucket = module.file_uploads_s3_logging_bucket.aws_logs_bucket

  cors_rules = var.cors_rules

  tags = {
    Name        = "S3 bucket for file uploads"
    Environment = var.environment
    Automation  = "Terraform"
  }
}

# we use a separate access logging bucket for every environment
module "file_uploads_s3_logging_bucket" {
  source  = "trussworks/logs/aws"
  version = "~> 10.0.0"

  s3_bucket_name          = local.file_uploads_s3_bucket_logs
  s3_log_bucket_retention = var.s3_logs_retention_days

  default_allow = false

  tags = {
    Name        = "S3 bucket for logs relating to file uploads"
    Environment = var.environment
    Automation  = "Terraform"

  }
}

