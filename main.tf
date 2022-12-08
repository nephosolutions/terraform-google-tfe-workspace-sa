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

resource "google_service_account" "tfe_workspace" {
  account_id   = "terraform-${lower(var.tfe_workspace_id)}"
  description  = "Impersonates service accounts but has no permission on any other resource."
  display_name = "Terraform Cloud authentication service account"
  project      = var.google_project_id
}

/* Create and and rotate service account keys. */
resource "time_rotating" "tfe_workspace_sa_key" {
  rotation_days = var.tfe_workspace_sa_key_rotation_days

  triggers = {
    tfe_workspace_id = var.tfe_workspace_id
  }
}

resource "google_service_account_key" "tfe_workspace_sa" {
  service_account_id = google_service_account.tfe_workspace.id

  keepers = {
    rotation_time = time_rotating.tfe_workspace_sa_key.rotation_rfc3339
  }

  lifecycle {
    create_before_destroy = true
  }
}
