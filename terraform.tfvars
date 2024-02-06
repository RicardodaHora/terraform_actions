# project           = "terraform-406817"
# region            = "us-central1"
# secret_data       = "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"
# remote_url        = "https://github.com/RicardodaHora/terraform.git"
datasets = {
    "dataset_1" = [
        {
            table_id = "table_1"
            schema_file="rm_valores.json"
        },
        {
            table_id = "table_2"
            schema_file="tabela1.json"
        }
    ]
}