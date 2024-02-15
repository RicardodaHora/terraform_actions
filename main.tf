terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.0" # Latest stable version
    }
  }
}

provider "google" {
  credentials = file("terraform-406817-71a350626408.json")
  project = "terraform-406817"
  region = "US"
}

resource "google_bigquery_table" "tables" {
  for_each = {for table in local.tables : "${table.dataset_id}.${table.table_id}" => table}
  dataset_id = each.value.dataset_id
  table_id =   each.value.table_id
  schema = file(each.value.schema_file)

  provisioner "local-exec" {
    command = <<EOF
      if ! bq --project_id=${google.project} ls ${each.value.dataset_id}:${each.value.table_id} > /dev/null 2>&1; then
        exit 1
      fi
    EOF
    interpreter = ["/bin/sh", "-c"]
    on_failure = continue
  }

  lifecycle {
    create_before_destroy = true
  }
}