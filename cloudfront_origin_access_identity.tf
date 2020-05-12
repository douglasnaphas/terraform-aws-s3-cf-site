resource "aws_cloudfront_origin_access_identity" "cf_oai" {
  comment = "${var.domain_name} cloudfront origin access identity, static content"
}
