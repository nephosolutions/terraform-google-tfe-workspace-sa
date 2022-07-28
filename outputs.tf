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

output "tfe_runner_sa" {
  description = "The Google Cloud service account for the TFE runner."
  value       = google_service_account.tfe_runner.email
}

output "tfe_workspace_sa" {
  description = "The Google Cloud service account for the TFE workspace."
  value       = google_service_account.tfe_workspace.email
}

output "tfe_workspace_sa_key" {
  description = "The Google Cloud credentials for the TFE workspace service account in JSON format, base64 encoded."
  sensitive   = true
  value       = google_service_account_key.tfe_workspace.private_key
}
