# Google service accounts for Terraform Cloud workspaces

This Terraform module provisions a Google service account for Terraform Cloud workspaces.

A Terraform Workspace service account is used to authenticate the Terraform Cloud workspace to the Google APIs.
The Google service account key for that account is rotated every 30 days.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.52 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.30.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_service_account.tfe_workspace](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.tfe_workspace_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [time_rotating.tfe_workspace_sa_key](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_project_id"></a> [google\_project\_id](#input\_google\_project\_id) | The Google Cloud Platform project ID | `string` | n/a | yes |
| <a name="input_tfe_workspace_id"></a> [tfe\_workspace\_id](#input\_tfe\_workspace\_id) | The Terraform Cloud workspace ID. | `string` | n/a | yes |
| <a name="input_tfe_workspace_sa_key_rotation_days"></a> [tfe\_workspace\_sa\_key\_rotation\_days](#input\_tfe\_workspace\_sa\_key\_rotation\_days) | Interval in days to rotate the workspace service account key. | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfe_workspace_sa"></a> [tfe\_workspace\_sa](#output\_tfe\_workspace\_sa) | The Google Cloud service account for the TFE workspace. |
| <a name="output_tfe_workspace_sa_key"></a> [tfe\_workspace\_sa\_key](#output\_tfe\_workspace\_sa\_key) | The Google Cloud credentials for the TFE workspace service account in JSON format, base64 encoded. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
