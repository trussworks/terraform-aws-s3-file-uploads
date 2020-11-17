
# terraform-aws-s3-upload

Creates the relevant infrastructure needed to handle AWS S3 file uploads.

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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.70 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.70 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_name | The name of the application | `string` | n/a | yes |
| cors\_rules | List of maps containing rules for Cross-Origin Resource Sharing. | `list(any)` | `[]` | no |
| environment | Environment level. | `string` | `"dev"` | no |
| file\_uploads\_bucket | The name of the S3 bucket used to store the uploads. | `string` | n/a | yes |
| lambda\_s3\_bucket | The name of the S3 bucket where the lambda build artifact is stored | `string` | n/a | yes |
| region | Application region. | `string` | `"us-west-2"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| virus\_scanning\_bucket | The name of the S3 bucket used to store virus scanning tools. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
