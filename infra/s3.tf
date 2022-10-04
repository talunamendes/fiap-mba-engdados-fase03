module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"
  bucket = "tf-s3-abdo6-grupo-o"
  acl = "private"
}

module "s3-bucket_object" {
  count= length(var.s3_objects_names)
  source  = "terraform-aws-modules/s3-bucket/aws//modules/object"
  version = "3.4.0"
  bucket = module.s3-bucket.s3_bucket_id
  key = var.s3_objects_names[count.index]
}