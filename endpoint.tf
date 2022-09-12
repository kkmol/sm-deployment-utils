resource "aws_sagemaker_endpoint" "endpoint" {
  name                 = var.service_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.endpoint_config.name

  deployment_config {
    blue_green_update_policy {
      traffic_routing_configuration {
        type                     = var.traffic_routing_configuration_type
        wait_interval_in_seconds = var.traffic_routing_configuration_wait
      }
      maximum_execution_timeout_in_seconds = var.blue_green_max_execution
      termination_wait_in_seconds          = var.blue_green_time_until_termination
    }
    auto_rollback_configuration {
      alarms {
        alarm_name = aws_cloudwatch_metric_alarm.invocation_4xx_errors_average.alarm_name
      }
    }
  }
  tags = local.common_tags
}