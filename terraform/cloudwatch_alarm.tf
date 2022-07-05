resource "aws_cloudwatch_metric_alarm" "ml_cpu" {
  alarm_name                = "tf_test"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/SageMaker"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors sagemaker real-time inference cpu utilization"
  insufficient_data_actions = []

  tags = local.common_tags
}
