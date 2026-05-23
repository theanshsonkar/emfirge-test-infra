# S3 buckets — some intentionally insecure for testing

resource "aws_s3_bucket" "public_data" {
  bucket = "prod-data-bucket"

  tags = {
    Name = "prod-data-bucket"
    Env  = "demo"
  }
}

resource "aws_s3_bucket_public_access_block" "public_data_block" {
  bucket = aws_s3_bucket.public_data.id

  # INTENTIONALLY INSECURE — public access allowed
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket" "logs" {
  bucket = "company-logs-2024"

  tags = {
    Name = "company-logs"
    Env  = "demo"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "logs_versioning" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}
