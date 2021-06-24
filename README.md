
# terraform-aws-s3-upload

Creates the relevant infrastructure needed to handle AWS S3 file uploads.

## Terraform Versions

Terraform 0.13. Pin module version to ~> x.x. Submit pull-requests to main branch.

Terraform 0.12. Pin module version to ~> x.x. Submit pull-requests to terraform012 branch.

## Anti-virus Scanning

Anti-virus scanning is handled via an AWS Lambda function using
[bucket-antivirus-function](https://github.com/upsidetravel/bucket-antivirus-function).

This package will need to be made and uploaded to wherever you keep Lambda artifacts. This bucket corresponds
to the `lambda_s3_bucket` configuration variable you pass to this module.


```sh
git clone git@github.com:upsidetravel/bucket-antivirus-function.git
cd bucket-antivirus-function
git checkout v2.0.0
```

With that repo checked out you must run the `make all` command and then copy the resulting zip file
to AWS S3 with:

```sh
VERSION=2.0.0
aws s3 cp bucket-antivirus-function/build/lambda.zip "s3://${lambda_s3_bucket}/anti-virus/${VERSION}/anti-virus.zip"
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_file_uploads_s3_bucket"></a> [file\_uploads\_s3\_bucket](#module\_file\_uploads\_s3\_bucket) | trussworks/s3-private-bucket/aws | ~>3.5.0 |
| <a name="module_file_uploads_s3_logging_bucket"></a> [file\_uploads\_s3\_logging\_bucket](#module\_file\_uploads\_s3\_logging\_bucket) | trussworks/logs/aws | ~> 10.3.0 |
| <a name="module_s3_anti_virus"></a> [s3\_anti\_virus](#module\_s3\_anti\_virus) | trussworks/s3-anti-virus/aws | ~>3.0.1 |
| <a name="module_virus_scan_s3_bucket"></a> [virus\_scan\_s3\_bucket](#module\_virus\_scan\_s3\_bucket) | trussworks/s3-private-bucket/aws | ~>3.5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The name of the application | `string` | n/a | yes |
| <a name="input_av_status_sns_arn"></a> [av\_status\_sns\_arn](#input\_av\_status\_sns\_arn) | SNS topic ARN to publish scan results to | `string` | n/a | yes |
| <a name="input_cloudwatch_logs_retention_days"></a> [cloudwatch\_logs\_retention\_days](#input\_cloudwatch\_logs\_retention\_days) | Number of days to keep logs in AWS CloudWatch. | `string` | `90` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | List of maps containing rules for Cross-Origin Resource Sharing. | `list(any)` | `[]` | no |
| <a name="input_create_logging_bucket"></a> [create\_logging\_bucket](#input\_create\_logging\_bucket) | Whether to create a new bucket for S3 access logs. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment level. | `string` | `"dev"` | no |
| <a name="input_file_uploads_bucket"></a> [file\_uploads\_bucket](#input\_file\_uploads\_bucket) | The name of the S3 bucket used to store the uploads. | `string` | n/a | yes |
| <a name="input_lambda_s3_bucket"></a> [lambda\_s3\_bucket](#input\_lambda\_s3\_bucket) | The name of the S3 bucket where the lambda build artifact is stored | `string` | n/a | yes |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | The name of the S3 bucket used for S3 access logs. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Application region. | `string` | `"us-west-2"` | no |
| <a name="input_s3_logs_retention_days"></a> [s3\_logs\_retention\_days](#input\_s3\_logs\_retention\_days) | Number of days to keep logs in S3. | `string` | `90` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_virus_scanning_bucket"></a> [virus\_scanning\_bucket](#input\_virus\_scanning\_bucket) | The name of the S3 bucket used to store virus scanning tools. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_uploads_bucket_arn"></a> [file\_uploads\_bucket\_arn](#output\_file\_uploads\_bucket\_arn) | ARN of the file uploads bucket |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
