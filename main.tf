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
   project = "terraform-406817"
   region = "US"
}
variable "datasets" {

}


locals {
  tables = flatten([
    for dataset_id, tables in local.datasets : [
      for table in tables : {
        dataset_id = dataset_id
        table_id = table.table_id
        schema_file = table.schema_file
      }
    ]
  ])
}


# locals {
#   #datasets = var.datasets
#   tables = flatten([
#     for dataset_id tables in local.datasets : [
#       for table in tables : {
#         dataset_id = dataset_id
#         table_id = table.table_id
#         schema_file = table.schema_file
#       }
#     ]
#   ])
# }

resource "google_bigquery_table" "tables" {
    for_each = {for table in local.tables : "${table.dataset_id}.${table.table_id}" => table}
    dataset_id = each.value.dataset_id
    table_id =   each.value.table_id
    schema = file(each.value.schema_file)
    depends_on = [ 
        google_bigquery_dataset.datasets
     ]
}

resource "google_bigquery_dataset" "datasets" {
    for_each = local.datasets
    dataset_id = each.key
}
