project           = "terraform-406817"
region            = "us-central1"
secret_data       = "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"
remote_url        = "https://github.com/RicardodaHora/terraform.git"
datasets = {
    "movies" = [
        {
            table_id = "table_1"
            schema_file="tabela1.json"
        },
        {
            table_id = "table_2"
            schema_file="tabela2.json"
        },
        {
            table_id = "table_3"
            schema_file="tabela3.json"
        },       
        {
            table_id = "table_4"
            schema_file="tabela4.json"
        }         
    ]
}
