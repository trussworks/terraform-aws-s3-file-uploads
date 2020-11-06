#
# Lambda function to create presigned URLs
#

locals {
  lambda_function_name = "getPresignedUrl"
}

resource "aws_lambda_function" "get_presigned_url" {
  filename         = data.archive_file.lambda_code.output_path
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  function_name    = local.lambda_function_name
  publish          = true
  role             = aws_iam_role.lambda_role.arn
  handler          = "upload.getPresignedUrl"
  runtime          = "nodejs12.x"

  environment {
    variables = {
      UPLOAD_BUCKET = var.file_uploads_bucket
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
  source_dir  = "${path.module}/lambda/dist"
  output_path = "${path.module}/lambda/upload.zip"
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
      "s3:PutObjectAcl",
    ]

    resources = ["arn:aws:s3:::${module.file_uploads_s3_bucket.name}/*"]
  }
}

#
# API Gateway for lambda
#
resource "aws_apigatewayv2_api" "get_presigned_url" {
  name          = local.lambda_function_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_route" "get_presigned_url" {
  api_id    = aws_apigatewayv2_api.get_presigned_url.id
  route_key = "GET /presignedurl"

  authorization_type = var.authorization_type
  authorizer_id      = aws_apigatewayv2_authorizer.get_presigned_url.id
}

resource "aws_apigatewayv2_integration" "get_presigned_url" {
  api_id             = aws_apigatewayv2_api.get_presigned_url.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  description        = "API gateway integration for file uploads"

  connection_type = "INTERNET"
  uri             = aws_lambda_function.get_presigned_url.invoke_arn
}

resource "aws_apigatewayv2_deployment" "get_presigned_url" {
  api_id      = aws_apigatewayv2_route.get_presigned_url.api_id
  description = "Deployment for API gateway in front of file upload lambda"

  lifecycle {
    create_before_destroy = true
  }
}

#
# Okta JWT auth for lambda
#
resource "aws_apigatewayv2_authorizer" "get_presigned_url" {
  api_id           = aws_apigatewayv2_api.get_presigned_url.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "${local.lambda_function_name}-authorizer"

  jwt_configuration {
    audience = [var.jwt_auth_audience]
    issuer   = var.jwt_auth_issuer
  }
}
