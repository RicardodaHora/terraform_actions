terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.5.0"
    }
  }
}

 provider "google-beta"{
   project = var.project
   region = var.region
 }

 data "google_secret_manager_secret" "existing_secret" {
   provider = google-beta
   secret_id = "dataform"
 }

 data "google_secret_manager_secret_version" "existing_secret_version" {
   provider = google-beta
   secret = data.google_secret_manager_secret.existing_secret.id
   version = "latest"
 }

resource "google_dataform_repository" "dataform_respository" {
  provider = google-beta
  name = "dataform"

  git_remote_settings {
      url = var.remote_url
      default_branch = "dataform-test"
      authentication_token_secret_version = data.google_secret_manager_secret_version.existing_secret_version.id      
  }

 }