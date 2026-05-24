```hcl
# EMFIRGE FIX: Public S3 bucket detected: acme-public-assets — consider adding CloudFront for better security and performance

resource "aws_s3_bucket_public_access_block" "acme_public_assets" {
  bucket = "acme-public-assets"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```