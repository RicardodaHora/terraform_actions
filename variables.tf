
variable "project" {
  type    = string
  default = "terraform-406817"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "service_account" {
  type    = string
  default = "service-491703034110@gcp-sa-dataform.iam.gserviceaccount.com"
}

variable "sa2" {
  type    = string
  default = "terraform@terraform-406817.iam.gserviceaccount.com"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "secret_git" {
  type    = string
  default = "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"
}

variable "secret_data" {
  type    = string
  default = "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"
}

#variable "credentials_file" { }

variable "zone" {
  default = "us-central1-c"
}

variable "remote_url" { 
  default = "https://github.com/RicardodaHora/terraform.git"
}










