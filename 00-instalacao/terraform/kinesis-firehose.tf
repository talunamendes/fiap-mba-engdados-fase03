
#---- AWS Kinesis firehose

resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose" {

  destination = "extended_s3"
  name = "firehose-grupo-o-ingest-json"

  extended_s3_configuration {
    buffer_size = 100
    buffer_interval = 300
    bucket_arn = module.s3-bucket.s3_bucket_arn
    role_arn = aws_iam_role.firehose_role_grupo_o.arn
    prefix = "ingested-json/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
    error_output_prefix = "ingested-json/!{firehose:error-output-type}/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
  }
  depends_on = [
    module.s3-bucket.s3_bucket_id,
    aws_iam_role.firehose_role_grupo_o
  ]
}

resource "aws_iam_role" "firehose_role_grupo_o" {
  name = "firehose_role_grupo_o"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_policy_grupo_o" {

  name = "s3_policy_grupo_o"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:GetObject",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:PutObject"
        ],
        "Effect": "Allow",
        "Resource":  [
          "arn:aws:s3:::s3-fiap-grupo-o/*",
          "arn:aws:s3:::s3-fiap-grupo-o/*"
        ]
      }
    ]
  }
  EOF
  depends_on = [
    module.s3-bucket.s3_bucket_id
  ]
}

resource "aws_iam_role_policy_attachment" "kns-s3-policy-attachment" {
  policy_arn = aws_iam_policy.s3_policy_grupo_o.arn
  role       = aws_iam_role.firehose_role_grupo_o.name
  depends_on = [
    aws_iam_policy.s3_policy_grupo_o,
    aws_iam_role.firehose_role_grupo_o
  ]
}