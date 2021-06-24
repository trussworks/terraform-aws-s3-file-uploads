module "s3_anti_virus" {
  source  = "trussworks/s3-anti-virus/aws"
  version = "~>3.0.1"

  lambda_s3_bucket = var.lambda_s3_bucket
  lambda_version   = "2.0.0"
  lambda_package   = "anti-virus"

  av_update_minutes = "180"
  av_scan_buckets   = [module.file_uploads_s3_bucket.name]

  av_definition_s3_bucket = module.virus_scan_s3_bucket.name

  av_status_sns_arn           = var.av_status_sns_arn
  av_status_sns_publish_clean = false

  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days

  tags = {
    Name        = "S3 bucket anti-virus scanning"
    Environment = var.environment
    Automation  = "Terraform"
  }

  depends_on = [
    module.file_uploads_s3_bucket,
  ]
}

#
# S3 Bucket for Anti-Virus Lambda and Definitions
#
module "virus_scan_s3_bucket" {
  source         = "trussworks/s3-private-bucket/aws"
  version        = "~>3.5.0"
  bucket         = var.virus_scanning_bucket
  logging_bucket = var.create_logging_bucket ? module.file_uploads_s3_logging_bucket.aws_logs_bucket : local.file_uploads_s3_bucket_logs

  tags = {
    Name        = "S3 bucket for virus scanning"
    Environment = var.environment
    Automation  = "Terraform"
  }
}
