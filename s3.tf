# S3 buckets — matching demo_seed.py resource IDs for end-to-end testing

resource "aws_s3_bucket" "public_assets" # EMFIRGE FIX: Public S3 bucket detected: acme-public-assets — consider adding CloudFront for better security and performance
resource "aws_s3_bucket_public_access_block" "acme_public_assets" {
  bucket = "acme-public-assets"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "public_assets_block" {
  bucket = aws_s3_bucket.public_assets.id

  # INTENTIONALLY INSECURE — public access allowed
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket" "data_lake" {
  bucket = "acme-data-lake"

  tags = {
    Name = "acme-data-lake"
    Env  = "demo"
  }
}

# INTENTIONALLY INSECURE — no encryption, no versioning (matches demo findings)

resource "aws_s3_bucket" "logs" {
  bucket = "acme-logs"

  tags = {
    Name = "acme-logs"
    Env  = "demo"
  }
}

resource "aws_s3_bucket" "app_static" {
  bucket = "acme-app-static"

  tags = {
    Name = "acme-app-static"
    Env  = "demo"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_static_encryption" {
  bucket = aws_s3_bucket.app_static.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "app_static_versioning" {
  bucket = aws_s3_bucket.app_static.id

  versioning_configuration {
    status = "Enabled"
  }
}
