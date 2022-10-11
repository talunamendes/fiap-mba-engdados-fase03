variable "s3_objects_names" {
  type = list
  default = ["small-files", "raw-json","ingested-json", "parquet"]
}

variable "sqs_names" {
  type = list
  default = ["tf-csv-to-json", "tf-json-to-firehose"]
}
