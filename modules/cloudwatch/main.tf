# Log group ECS
resource "aws_cloudwatch_log_group" "ecs_app_logs" {
  name              = "/ecs/${var.project}/app"
  retention_in_days = var.retention_in_days

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-ecs-logs"
  })
}

# Metric filter pour erreurs dans logs ECS
resource "aws_cloudwatch_log_metric_filter" "ecs_errors" {
  name           = "ecs-error-filter"
  log_group_name = aws_cloudwatch_log_group.ecs_app_logs.name
  pattern        = "?ERROR ?Error ?error"

  metric_transformation {
    name      = "EcsErrorCount"
    namespace = "ECS/${var.project}"
    value     = "1"
  }
}

# Alarme sur erreurs ECS
resource "aws_cloudwatch_metric_alarm" "ecs_error_alarm" {
  alarm_name          = "${var.project}-ecs-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 1
  statistic           = "Sum"
  period              = 60
  metric_name         = aws_cloudwatch_log_metric_filter.ecs_errors.metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.ecs_errors.metric_transformation[0].namespace
  alarm_description   = "Trop d’erreurs dans ECS"

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-ecs-error-alarm"
  })
}

# Alarme sur connexions Aurora
resource "aws_cloudwatch_metric_alarm" "aurora_conn_alarm" {
  alarm_name          = "${var.project}-aurora-conn"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 80
  statistic           = "Average"
  period              = 60
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  dimensions = {
    DBClusterIdentifier = var.aurora_cluster_id
  }

  alarm_description = "Trop de connexions Aurora"
  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-aurora-alarm"
  })
}

# Alarme sur erreurs ALB (5XX)
resource "aws_cloudwatch_metric_alarm" "alb_5xx_alarm" {
  alarm_name          = "${var.project}-alb-5xx"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 5
  statistic           = "Sum"
  period              = 60
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  dimensions = {
    LoadBalancer = var.alb_metric_name
  }

  alarm_description = "ALB retourne trop de 5xx"
  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-alb-alarm"
  })
}

# Alarme sur WAF blocages
resource "aws_cloudwatch_metric_alarm" "waf_blocked_alarm" {
  alarm_name          = "${var.project}-waf-blocks"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 10
  statistic           = "Sum"
  period              = 60
  metric_name         = "BlockedRequests"
  namespace           = "AWS/WAFV2"
  dimensions = {
    WebACL = var.waf_metric_name
    Region = "global"
  }

  alarm_description = "Trop de requêtes bloquées par WAF"
  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-waf-alarm"
  })
}
