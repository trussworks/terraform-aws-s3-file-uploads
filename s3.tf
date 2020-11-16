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
  file_uploads_s3_bucket_logs = "${var.application_name}-${var.environment}-${var.file_uploads_bucket}-logs"
  antivirus_version           = "2.0.0"
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

#
# S3 Bucket for Anti-Virus Lambda and Definitions
#
module "virus_scan_s3_bucket" {
  source         = "trussworks/s3-private-bucket/aws"
  version        = "~>2.1.0"
  bucket         = var.virus_scanning_bucket
  logging_bucket = module.file_uploads_s3_logging_bucket.aws_logs_bucket

  tags = {
    Name        = "S3 bucket for virus scanning"
    Environment = var.environment
    Automation  = "Terraform"
  }
}

#
# S3 object containing the lambda
#
resource "aws_s3_bucket_object" "av_lambda" {
  bucket = var.virus_scanning_bucket
  key    = "anti-virus/${local.antivirus_version}/anti-virus.zip"
  source = "lambda/lambda-${local.antivirus_version}.zip"
}

