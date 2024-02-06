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

resource "google_bigquery_table" "tabela_teste" {
  dataset_id = "movies" // Substitua YYYY pelo ID do seu dataset
  table_id   = "tabela_teste"

  schema = <<EOF
[
  {
    "name": "coluna1",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "coluna2",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "coluna3",
    "type": "FLOAT",
    "mode": "NULLABLE"
  }
]
EOF
}