data "aws_route53_zone" "zone" {
  name = "${var.zone_name}"
}

resource "aws_route53_record" "cf_alias" {
  alias {
    evaluate_target_health = "false"
    name                   = "${aws_cloudfront_distribution.cf_distro.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cf_distro.hosted_zone_id}"
  }

  name    = "${var.domain_name}"
  type    = "A"
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
}
