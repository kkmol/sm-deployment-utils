## Invocation Alarms
resource "aws_cloudwatch_metric_alarm" "model_latency_average" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-model-latency-average-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "ModelLatency"
  namespace                 = "AWS/SageMaker"
  period                    = "30"
  statistic                 = "Average"
  threshold                 = "20000"
  alarm_description         = "SageMaker ${var.service_name}-${var.model_variant_name} high average model latency. (The interval of time taken by a model to respond)"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "model_latency_max" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-model-latency-max-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ModelLatency"
  namespace                 = "AWS/SageMaker"
  period                    = "30"
  statistic                 = "Maximum"
  threshold                 = "30000"
  alarm_description         = "SageMaker ${var.service_name}-${var.model_variant_name} high max model latency. (The interval of time taken by a model to respond)"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "overhead_latency_average" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-overhead-latency-average-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "OverheadLatency"
  namespace                 = "AWS/SageMaker"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "20000"
  alarm_description         = "SageMaker ${var.service_name}-${var.model_variant_name} high average model latency. (The interval of time added to the time taken to respond to a client request by SageMaker overheads)"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "overhead_latency_max" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-overhead-latency-max-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "OverheadLatency"
  namespace                 = "AWS/SageMaker"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "50000"
  alarm_description         = "SageMaker ${var.service_name}-${var.model_variant_name} high max model latency. (The interval of time added to the time taken to respond to a client request by SageMaker overheads)"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "invocation_4xx_errors_average" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-4xx-errors-average-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "Invocation4XXErrors"
  namespace                 = "AWS/SageMaker"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "2"
  alarm_description         = "SageMaker ${var.service_name}-${var.model_variant_name} high average 4xx errors. (The number of requests where a 4xx HTTP code is returned)"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "invocation_5xx_errors" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-5xx-errors"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "Invocation5XXErrors"
  namespace                 = "AWS/SageMaker"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "SageMaker ${var.service_name}-${var.model_variant_name} 5xx errors. (The number of requests where a 5xx HTTP code is returned)"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

# resource "aws_cloudwatch_metric_alarm" "invocations" {
#   alarm_name                = "${var.service_name}-${var.model_variant_name}-anomalous-invocations"
#   comparison_operator       = "GreaterThanUpperThreshold"
#   evaluation_periods        = "2"
#   threshold_metric_id       = "${var.service_name}-${var.model_variant_name}-anomalous-invocations-metric"
#   alarm_description         = "SageMaker ${var.service_name}-${var.model_variant_name} anomalous invocations. (The number of total requests)"
#   insufficient_data_actions = []
#   alarm_actions             = [var.sns_alarm_topic_arn]
#   ok_actions                = [var.sns_alarm_topic_arn]

#   metric_query {
#     id          = "${var.service_name}-${var.model_variant_name}-anomalous-invocations-metric"
#     expression  = "ANOMALY_DETECTION_BAND(${var.service_name}-${var.model_variant_name}-invocations-metric)"
#     label       = "Invocations (Expected)"
#     return_data = "true"
#   }

#   metric_query {
#     id          = "${var.service_name}-${var.model_variant_name}-invocations-metric"
#     return_data = "true"
#     metric {
#       metric_name = "Invocations"
#       namespace   = "AWS/SageMaker"
#       period      = "120"
#       stat        = "Sum"
#       unit        = "Count"
#     }
#   }

#   tags = local.common_tags
# }


## Instance Alarms
resource "aws_cloudwatch_metric_alarm" "cpu_average" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-cpu-average"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/SageMaker"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "Sagemaker real-time inference average cpu utilization"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "cpu_max" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-cpu-max"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/SageMaker"
  period                    = "120"
  statistic                 = "Maximum"
  threshold                 = "80"
  alarm_description         = "Sagemaker real-time inference max cpu utilization"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "disk_average" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-disk-average"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "DiskUtilization"
  namespace                 = "AWS/SageMaker"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "Sagemaker real-time inference disk utilization"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "memory_average" {
  alarm_name                = "${var.service_name}-${var.model_variant_name}-memory-average"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/SageMaker"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "50"
  alarm_description         = "Sagemaker real-time inference average memory utilization"
  insufficient_data_actions = []
  alarm_actions             = [var.sns_alarm_topic_arn]
  ok_actions                = [var.sns_alarm_topic_arn]

  tags = local.common_tags
}