resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "frontend" {
  bucket = "${var.name_prefix}-frontend-${random_id.suffix.hex}"

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-frontend"
  })
}

resource "aws_s3_bucket_public_access_block" "frontend_block" {
  bucket                  = aws_s3_bucket.frontend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# (Optionnel) bucket pour logs CloudFront
resource "aws_s3_bucket" "cf_logs" {
  bucket = "${var.name_prefix}-cf-logs-${random_id.suffix.hex}"

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-cf-logs"
  })
}

resource "aws_s3_bucket_acl" "cf_logs_acl" {
  bucket = aws_s3_bucket.cf_logs.id
  acl    = "log-delivery-write"
}

# (à appeler depuis cloudfront) : bucket_policy autorisant l'accès via OAC
resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend.id

  policy = var.oac_policy_json
}
