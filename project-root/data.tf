data "aws_iam_policy_document" "oac_policy" {
  statement {
    actions = ["s3:GetObject"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    resources = ["arn:aws:s3:::${var.name_prefix}-frontend-*/*"]
  }
}
