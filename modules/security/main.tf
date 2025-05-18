data "aws_iam_policy_document" "trail" {
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.trail_logs.arn}/*"
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}


# CloudTrail (global)
resource "aws_cloudtrail" "main" {
  name                          = "${var.project}-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.trail_logs.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  is_organization_trail         = false
  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.cloudtrail.arn
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
  kms_key_id                    = aws_kms_key.trail_logs_key.arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-cloudtrail"
  })
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name       = "/aws/cloudtrail/${var.project}"
  kms_key_id = aws_kms_key.cloudwatch_key.arn
}

resource "aws_kms_key" "cloudwatch_key" {
  description         = "Key for encrypting CloudWatch logs"
  enable_key_rotation = true
}

resource "aws_iam_role" "cloudtrail_role" {
  name = "${var.project}-cloudtrail-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cloudtrail_logs" {
  role       = aws_iam_role.cloudtrail_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCloudTrailFullAccess"
}

resource "aws_kms_key" "trail_logs_key" {
  description         = "KMS key for CloudTrail logs encryption"
  enable_key_rotation = true
}

resource "aws_s3_bucket" "trail_logs" {
  bucket = "${var.project}-cloudtrail-logs"

  logging {
    target_bucket = aws_s3_bucket.trail_logs_logs.id
    target_prefix = "trail-logs/"
  }

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-trail-bucket"
  })
}

resource "aws_s3_bucket_acl" "trail_logs_acl" {
  bucket = aws_s3_bucket.trail_logs.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "trail_policy" {
  bucket = aws_s3_bucket.trail_logs.id
  policy = data.aws_iam_policy_document.trail.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "trail_logs_encryption" {
  bucket = aws_s3_bucket.trail_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.trail_logs_key.arn
    }
  }
}

resource "aws_s3_bucket_versioning" "trail_logs_versioning" {
  bucket = aws_s3_bucket.trail_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "trail_logs_block" {
  bucket                  = aws_s3_bucket.trail_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "trail_logs_logs" {
  bucket = "${var.project}-trail-logs-bucket"

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-trail-logs-target"
  })
}

resource "aws_s3_bucket_acl" "trail_logs_logs_acl" {
  bucket = aws_s3_bucket.trail_logs_logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_public_access_block" "trail_logs_logs_block" {
  bucket                  = aws_s3_bucket.trail_logs_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "trail_logs_logs_encryption" {
  bucket = aws_s3_bucket.trail_logs_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "trail_logs_logs_versioning" {
  bucket = aws_s3_bucket.trail_logs_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# GuardDuty
resource "aws_guardduty_detector" "main" {
  enable = true

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-guardduty"
  })
}

# AWS Budgets
resource "aws_budgets_budget" "monthly" {
  name         = "${var.project}-monthly-budget"
  budget_type  = "COST"
  time_unit    = "MONTHLY"

  limit_amount = var.budget_limit
  limit_unit   = "USD"

  time_period_start = "2024-01-01_00:00"
  time_period_end   = "2087-01-01_00:00"

  cost_filter {
    name   = "Service"
    values = ["Amazon Elastic Compute Cloud - Compute"]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.budget_notification_email]
  }

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-budget"
  })
}
