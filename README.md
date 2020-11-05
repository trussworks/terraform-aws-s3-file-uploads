
# terraform-aws-s3-upload

Creates the relevant infrastructure needed to handle AWS S3 file uploads.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.70 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | ~> 2.70 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_name | The name of the application | `string` | n/a | yes |
| authorization\_type | The type of authorization used for the lambda | `string` | `"JWT"` | no |
| cors\_rules | List of maps containing rules for Cross-Origin Resource Sharing. | `list(any)` | `[]` | no |
| environment | Environment level. | `string` | `"dev"` | no |
| file\_uploads\_bucket | The name of the S3 bucket used to store the uploads. | `string` | n/a | yes |
| jwt\_auth\_audience | The jwt audience used to verify authorization to the lambda | `string` | n/a | yes |
| jwt\_auth\_issuer | The url to the jwt issuer to verify authorization to the lambda | `string` | n/a | yes |
| region | Application region. | `string` | `"us-west-2"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
