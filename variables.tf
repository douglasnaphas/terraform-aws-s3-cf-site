variable "bucket_name" {
  description = "Name of the S3 bucket that will hold the site's static assets"
}

variable "domain_name" {
  description = "The host name for the URL for viewing the site"
}

variable "ci_user_arn" {
  description = "arn of the user for the CI build"
}

variable "zone_name" {
  description = "name of the Route53 hosted zone where the domain lives"
}

variable "cert_arn" {
  description = "cert arn"
}
