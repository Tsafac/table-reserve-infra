# CloudTrail (global)
resource "aws_cloudtrail" "main" {
  name                          = "${var.project}-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.trail_logs.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  is_organization_trail         = false

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

resource "aws_s3_bucket" "trail_logs" {
  bucket = "${var.project}-cloudtrail-logs"

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

data "aws_iam_policy_document" "trail" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::bucket/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}


# GuardDuty
resource "aws_guardduty_detector" "main" {
  enable = true

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-guardduty"
  })
}

#AWS Budgets
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



