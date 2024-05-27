locals {
  bucket_name = "s3-${var.namespace}-${var.environment}-www"
}

resource "aws_s3_bucket" "www" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.www.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureConnections"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${aws_s3_bucket.www.arn}/*",
          "${aws_s3_bucket.www.arn}"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid    = "AllowCloudFrontServicePrincipal",
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.www.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "${aws_cloudfront_distribution.main.arn}"
          }
        }
      }
    ]
  })

  depends_on = [aws_s3_bucket.www, aws_cloudfront_distribution.main]
}

output "s3_bucket_name" {
  value = aws_s3_bucket.www.bucket
}
