provider "aws" {
  region = "ap-south-1"
}

# S3 Bucket
resource "aws_s3_bucket" "site" {
  bucket = "ecommerce-site-amar-2026"
}

# Website Configuration
resource "aws_s3_bucket_website_configuration" "site_config" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Public Access Settings
resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket Policy (VERY IMPORTANT )
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = "${aws_s3_bucket.site.arn}/*"
      }
    ]
  })
}
