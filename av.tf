module "s3_anti_virus" {
  source  = "trussworks/s3-anti-virus/aws"
  version = "~>2.1.0"

  lambda_s3_bucket = var.virus_scanning_bucket
  lambda_version   = "2.0.0"
  lambda_package   = "anti-virus"

  av_update_minutes = "180"
  av_scan_buckets   = [module.file_uploads_s3_bucket.name]

  av_definition_s3_bucket = var.virus_scanning_bucket

  tags = {
    Name        = "S3 bucket anti-virus scanning"
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

