module "sqs-with-dlq" {
  count= length(var.sqs_names)
  source  = "git::git@github.com:damacus/terraform-aws-sqs-with-dlq.git"
  name = var.sqs_names[count.index]
}