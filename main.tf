terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.5.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-406817-71a350626408.json")
  project     = "terraform-406817"
  region      = "US"
}

resource "google_project" "project" {
  provider = google
  project_id = "terraform-406817"
  name = "Terraform"
}

variable "datasets" {
  default = {}
}

locals {
  datasets = var.datasets
  tables = flatten([
    for dataset_id, tables in local.datasets: [
      for table in tables : {
        dataset_id = dataset_id
        table_id   = table.table_id
        schema_file = table.schema_file
      }
    ]
  ])
}

resource "google_bigquery_table" "tables" {
  for_each = { for table in local.tables : "${table.dataset_id}.${table.table_id}" => table }

  dataset_id = each.value.dataset_id
  table_id   = each.value.table_id
  schema     = file(each.value.schema_file)

  lifecycle {
    create_before_destroy = true

    prevent_destroy = false

    ignore_changes = [
      schema
    ]
  }

  # Only create the table if it doesn't already exist
  provisioner "local-exec" {
    command = <<-EOT
      if ! bq --project_id=${google_project.project.project_id} show --schema --format=prettyjson ${each.value.dataset_id}.${each.value.table_id} > /dev/null 2>&1; then
        bq --project_id=${google_project.project.project_id} mk ${each.value.dataset_id}.${each.value.table_id} < ${each.value.schema_file}
      fi
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}