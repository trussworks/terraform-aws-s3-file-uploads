
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
| terraform | ~> 0.13.0 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_name | The name of the application | `string` | n/a | yes |
| av\_status\_sns\_arn | SNS topic ARN to publish scan results to | `string` | n/a | yes |
| cloudwatch\_logs\_retention\_days | Number of days to keep logs in AWS CloudWatch. | `string` | `90` | no |
| cors\_rules | List of maps containing rules for Cross-Origin Resource Sharing. | `list(any)` | `[]` | no |
| environment | Environment level. | `string` | `"dev"` | no |
| file\_uploads\_bucket | The name of the S3 bucket used to store the uploads. | `string` | n/a | yes |
| lambda\_s3\_bucket | The name of the S3 bucket where the lambda build artifact is stored | `string` | n/a | yes |
| region | Application region. | `string` | `"us-west-2"` | no |
| s3\_logs\_retention\_days | Number of days to keep logs in S3. | `string` | `90` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| virus\_scanning\_bucket | The name of the S3 bucket used to store virus scanning tools. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
