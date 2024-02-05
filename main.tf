variable "dataset_id" {
  description = "O ID do conjunto de dados do BigQuery"
  type        = string
  default     = "terraform-406817"
}

resource "google_bigquery_dataset" "default" {
  dataset_id = var.dataset_id
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