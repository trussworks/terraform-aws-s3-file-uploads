# The AWS region currently being used.
data "aws_region" "current" {}

# The AWS account id
data "aws_caller_identity" "current" {}

# The AWS partition (commercial or govcloud)
data "aws_partition" "current" {}

locals {
  file_uploads_s3_bucket_logs = var.logging_bucket == "" ? "${var.application_name}-${var.environment}-${var.file_uploads_bucket}-logs" : var.logging_bucket
  antivirus_version           = "2.0.0"
}
