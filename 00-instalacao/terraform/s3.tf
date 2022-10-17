
#---- AWS S3

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"
  bucket = "s3-fiap-grupo-o"
  acl = "private"
}