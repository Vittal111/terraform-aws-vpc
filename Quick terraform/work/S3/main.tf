provider "aws" {
  region = "us-east-1"
}
variable "bucket" {
  type = string
  description = "enter the unique bucket name :"
}
variable "log_bucket" {
  type = string
  description = "enter log bucket name :"
}
resource "aws_s3_bucket" "demo" {
  bucket = var.bucket
  acl = "public-read"
  tags = {
    "envi" = "dev"
  }
  policy = file("./policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
versioning {
  enabled = true
}
logging {
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "logs/"
}
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.log_bucket
  acl = "log-delivery-write"

  lifecycle {
    id = "log"
    enabled = true
    prefix = "/log"
  }
  transition{
    days = 30
    storage_class = "STANDARD_IA"
  }
  transition{
    days = 60
    storage_class = "GLACIER"
  }
  expiration{
    days = 90
  }
object_lock_enabled = true


cors_rule {
  allowed_headers = ["*"]
  allowed_methods = ["PUT","POST"]
  allowed_origins = ["https://s3-website-test.hashicorp.com"]
  expose_headers  = ["ETag"]
  max_age_seconds = 3000
}
}