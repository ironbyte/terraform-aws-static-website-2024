resource "cloudflare_record" "acm_dns_validation" {
  for_each = { for dvo in aws_acm_certificate.cloudfront_dist_cert.domain_validation_options : dvo.domain_name => {
    name  = dvo.resource_record_name
    value = dvo.resource_record_value
    type  = dvo.resource_record_type
  } }

  zone_id = var.cf_zone_id
  name    = each.value.name
  value   = each.value.value
  type    = each.value.type
}

resource "cloudflare_record" "cfront_dist_cname_record" {
  zone_id    = var.cf_zone_id
  name       = "${var.namespace}-${var.environment}"
  value      = aws_cloudfront_distribution.main.domain_name
  type       = "CNAME"
  proxied    = true
  depends_on = [aws_cloudfront_distribution.main]
}

output "cloudflare_hostname" {
  value = cloudflare_record.cfront_dist_cname_record.hostname
}
