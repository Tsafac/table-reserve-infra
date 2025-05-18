resource "random_id" "suffix" {
  byte_length = 4
}

# ──────────────── S3 Bucket Frontend ────────────────
resource "aws_s3_bucket" "frontend" {
  bucket = "${var.name_prefix}-frontend-${random_id.suffix.hex}"

  logging {
    target_bucket = aws_s3_bucket.cf_logs.id
    target_prefix = "frontend-logs/"
  }

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-frontend"
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "frontend_encryption" {
  bucket = aws_s3_bucket.frontend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_arn

    }
  }
}


resource "aws_s3_bucket_versioning" "frontend_versioning" {
  bucket = aws_s3_bucket.frontend.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend_block" {
  bucket                  = aws_s3_bucket.frontend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ──────────────── S3 Bucket CloudFront Logs ────────────────
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

resource "aws_s3_bucket_server_side_encryption_configuration" "cf_logs_encryption" {
  bucket = aws_s3_bucket.cf_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "cf_logs_versioning" {
  bucket = aws_s3_bucket.cf_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "cf_logs_block" {
  bucket                  = aws_s3_bucket.cf_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ──────────────── Policy pour CloudFront (OAC) ────────────────
resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend.id
  policy = var.oac_policy_json
}

data "aws_iam_policy_document" "oac_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::your-bucket-name/*"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}

