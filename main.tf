# Copyright 2022 NephoSolutions srl, Sebastian Trebitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

data "google_project" "project" {
  project_id = var.google_project_id
}

resource "google_service_account" "tfe_runner" {
  account_id   = random_id.google_service_account["tfe_runner"].hex
  description  = "Manages service accounts and IAM permissions."
  display_name = "Terraform Cloud management service account"
  project      = data.google_project.project.project_id
}

resource "google_service_account" "tfe_workspace" {
  account_id   = random_id.google_service_account["tfe_workspace"].hex
  description  = "Impersonates service accounts but has no permission on any other resource."
  display_name = "Terraform Cloud authentication service account"
  project      = data.google_project.project.project_id
}

resource "google_service_account_iam_binding" "tfe_runner" {
  for_each = toset([
    /* Impersonate service accounts (create OAuth2 access tokens, sign blobs or JWTs, etc). */
    "roles/iam.serviceAccountTokenCreator",

    /* Run operations as the service account. */
    "roles/iam.serviceAccountUser",
  ])

  service_account_id = google_service_account.tfe_runner.name
  role               = each.value

  members = [
    "serviceAccount:${google_service_account.tfe_workspace.email}",
  ]
}

/* Create and manage (and rotate) service account keys. */
resource "google_service_account_iam_binding" "tfe_workspace" {
  service_account_id = google_service_account.tfe_workspace.name
  role               = "roles/iam.serviceAccountKeyAdmin"

  members = var.tfe_workspace_sa_key_admins
}

resource "google_service_account_key" "tfe_workspace" {
  service_account_id = google_service_account_iam_binding.tfe_workspace.service_account_id

  keepers = {
    rotation_time = time_rotating.google_service_account_key.rotation_rfc3339
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_id" "google_service_account" {
  for_each = toset([
    "tfe_runner",
    "tfe_workspace",
  ])

  byte_length = 4
  prefix      = "${lower(var.tfe_workspace_id)}-"
}

resource "time_rotating" "google_service_account_key" {
  rotation_days = var.tfe_workspace_sa_key_rotation_days

  triggers = {
    tfe_workspace_id = var.tfe_workspace_id
  }
}
