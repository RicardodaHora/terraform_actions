provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "terraform-406817"
  location   = "US"
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "tabela_test"

  schema = <<EOF
[
  {
    "name": "coluna1",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "coluna2",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "coluna3",
    "type": "FLOAT",
    "mode": "REQUIRED"
  }
]
EOF
}