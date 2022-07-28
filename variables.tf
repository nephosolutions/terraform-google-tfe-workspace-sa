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

variable "google_project_id" {
  description = "The Google Cloud Platform project ID"
  type        = string
}

variable "tfe_workspace_id" {
  description = "The Terraform Cloud workspace ID."
  type        = string
}

variable "tfe_workspace_sa_key_admins" {
  description = "List of Terraform workspace service account key admins."
  type        = list(string)
}

variable "tfe_workspace_sa_key_rotation_days" {
  default     = 30
  description = "Interval in days to rotate the workspace service account key."
  type        = number
}
