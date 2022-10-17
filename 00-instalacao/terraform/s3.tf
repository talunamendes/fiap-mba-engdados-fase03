
#---- AWS S3
/*
resource "aws_s3_bucket" "bucket_s3" {
  bucket = "s3-fiap-grupo-o"
}

resource "aws_s3_bucket_acl" "bucket_s3_acl" {
  bucket = aws_s3_bucket.bucket_s3.id
  acl    = "private"
  depends_on = [
    bucket_s3
  ]
}
*/

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"
  bucket = "s3-fiap-grupo-o"
  acl = "private"
}