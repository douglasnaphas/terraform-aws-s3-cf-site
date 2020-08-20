resource "aws_cloudfront_distribution" "cf_distro" {
  aliases = ["${var.domain_name}"]
  comment = "${var.domain_name}, using OAI"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["HEAD", "GET"]
    compress        = "false"
    default_ttl     = "300"

    forwarded_values {
      cookies {
        forward = "none"
      }

      query_string = "true"
    }

    max_ttl                = "86400"
    min_ttl                = "0"
    smooth_streaming       = "false"
    target_origin_id       = "S3-${var.bucket_name}"
    viewer_protocol_policy = "redirect-to-https"
  }

  enabled         = "true"
  is_ipv6_enabled = "true"

  origin {
    domain_name = "${var.bucket_name}.s3.amazonaws.com"
    origin_id   = "S3-${var.bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf_oai.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.cert_arn
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.1_2016"
    ssl_support_method             = "sni-only"
  }
}
