resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.bucket.bucket}"

  policy = <<POLICY
{
  "Id": "PolicyForAUIProdBucket",
  "Statement": [
    {
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_cloudfront_origin_access_identity.cf_oai.iam_arn}"
      },
      "Resource": "${aws_s3_bucket.bucket.arn}/*",
      "Sid": "Read access for CloudFront Origin Access Identity"
    },
    {
      "Action": [
        "s3:DeleteObject",
        "s3:DeleteObjectVersion",
        "s3:GetBucketAcl",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl",
        "s3:ListBucket",
        "s3:PutBucketAcl",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.ci_user_arn}"
      },
      "Resource": [
        "${aws_s3_bucket.bucket.arn}/*",
        "${aws_s3_bucket.bucket.arn}"
      ],
      "Sid": "Read/write access for CIs"
    }
  ],
  "Version": "2008-10-17"
}
POLICY
}
