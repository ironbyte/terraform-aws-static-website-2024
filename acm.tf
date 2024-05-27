locals {
  main_domain = "${var.namespace}-${var.environment}.${var.cf_domain_name}"
}

resource "aws_acm_certificate" "cloudfront_dist_cert" {
  provider          = aws.aws_us_east_1
  domain_name       = local.main_domain
  validation_method = "DNS"
  key_algorithm     = "EC_prime256v1"
}

resource "aws_acm_certificate_validation" "acm_validation" {
  provider                = aws.aws_us_east_1
  certificate_arn         = aws_acm_certificate.cloudfront_dist_cert.arn
  validation_record_fqdns = [for record in aws_acm_certificate.cloudfront_dist_cert.domain_validation_options : record.resource_record_name]

  depends_on = [aws_acm_certificate.cloudfront_dist_cert]
}
