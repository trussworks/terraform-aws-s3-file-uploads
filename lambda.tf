#
# Lambda function to create presigned URLs
#

locals {
  lambda_function_name = "getPresignedUrl"
}

resource "aws_lambda_function" "function" {
  filename         = data.archive_file.function_code.output_path
  source_code_hash = data.archive_file.function_code.output_base64sha256
  function_name    = local.lambda_function_name
  publish          = true
  role             = aws_iam_role.lambda_role.arn
  handler          = "upload.getPresignedUrl"
  runtime          = "nodejs12.x"

  environment {
    variables = {
      UploadBucket = var.file_uploads_bucket
    }
  }

  tags = {
    Name        = "Lambda function to generate presigned URLs for uploads"
    Environment = var.environment
    Automation  = "Terraform"
  }
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.module}/lambda/dist/upload.js"
  output_path = "${path.module}/lambda/dist/upload.zip"
}

#
# IAM policies for lambda function
#
resource "aws_iam_role" "lambda_role" {
  name_prefix        = local.lambda_function_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy" "lambda_policy" {
  name_prefix = local.lambda_function_name
  role        = aws_iam_role.lambda_role.id
  policy      = data.aws_iam_policy_document.lambda_execution_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_execution_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PubObjectAcl",
    ]

    resources = ["arn:aws:s3:::${module.file_uploads_s3_bucket.name}/*"]
  }
}


