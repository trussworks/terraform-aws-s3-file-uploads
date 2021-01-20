# The AWS region currently being used.
data "aws_region" "current" {}

# The AWS account id
data "aws_caller_identity" "current" {}

# The AWS partition (commercial or govcloud)
data "aws_partition" "current" {}

locals {
  antivirus_version           = "2.0.0"
}
