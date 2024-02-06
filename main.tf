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

resource "google_bigquery_dataset" "default" {
  dataset_id = "movies"
  location   = "US"
}

resource "google_bigquery_table" "tables" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "tabela_test"

  schema = <<EOF
[
  {
    "name": "coluna1",
    "type": "STRING"

  },
  {
    "name": "coluna2",
    "type": "STRING"
  },
  {
    "name": "coluna3",
    "type": "INTEGER"
  }
]
EOF
}