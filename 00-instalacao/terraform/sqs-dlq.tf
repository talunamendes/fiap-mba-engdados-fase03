#---- AWS SQS com DLQ

module "sqs-with-dlq" {
  count= length(var.sqs_names)
  source  = "git::git@github.com:damacus/terraform-aws-sqs-with-dlq.git"
  name = var.sqs_names[count.index]
}

/*

resource "aws_sqs_queue" "raw_json_dlq" {
  name = "raw-json-dlq"
}

resource "aws_sqs_queue_policy" "raw_json_dlq_policy" {
  queue_url = aws_sqs_queue.raw_json_dlq.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.raw_json_dlq.arn}"
    }
  ]
}
POLICY
  depends_on = [
    raw_json_dlq
  ]
}

resource "aws_sqs_queue" "raw_json" {
  name                      = "raw-json"
  delay_seconds             = 20
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0
  visibility_timeout_seconds = 120
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.raw_json_dlq.arn
    maxReceiveCount     = 50
  })
  depends_on = [
    raw_json_dlq
  ]
  tags = {
    Environment = "production"
  }
}

resource "aws_sqs_queue_policy" "raw_json_policy" {
  queue_url = aws_sqs_queue.raw_json.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.raw_json.arn}"
    }
  ]
}
POLICY
  depends_on = [
    raw_json
  ]
}

resource "aws_sqs_queue" "small_files_csv_dlq" {
  name = "small-files-csv-dql"
}

resource "aws_sqs_queue_policy" "small_files_csv_dlq_policy" {
  queue_url = aws_sqs_queue.small_files_csv_dlq.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.small_files_csv_dlq.arn}"
    }
  ]
}
POLICY
  depends_on = [
    small_files_csv_dlq
  ]
}

resource "aws_sqs_queue" "small_files_csv" {
  name                      = "small-files-csv"
  delay_seconds             = 20
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0
  visibility_timeout_seconds = 120
  drive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.small_files_csv_dlq.arn
    maxReceiveCount     = 1
  })
  depends_on = [
    small_files_csv_dlq
  ]
  tags = {
    Environment = "production"
  }
}

resource "aws_sqs_queue_policy" "small_files_csv_policy" {
  queue_url = aws_sqs_queue.small_files_csv.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.small_files_csv.arn}"
    }
  ]
}
POLICY
  depends_on = [
    small_files_csv
  ]

}
*/
