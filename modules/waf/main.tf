resource "aws_wafv2_web_acl" "waf" {
  name        = "waf-${var.project}"
  scope       = "CLOUDFRONT"
  description = "WAF for ${var.project}"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf-${var.project}"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "common-rule"
      sampled_requests_enabled   = true
    }
  }

  tags = merge(var.default_tags, {
    Name = var.domain_name
  })
}

resource "aws_wafv2_web_acl_association" "alb_waf" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}
