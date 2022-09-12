resource "aws_appautoscaling_target" "sm_target" {
  count              = var.autoscaling_enabled ? 1 : 0
  min_capacity       = var.autoscaling_minimum_tasks
  max_capacity       = var.autoscaling_maximum_tasks
  resource_id        = "endpoint/${aws_sagemaker_endpoint.endpoint.name}/variant/${var.model_variant_name}"
  role_arn           = aws_iam_role.sagemaker_execution.arn
  scalable_dimension = "sagemaker:variant:DesiredInstanceCount"
  service_namespace  = "sagemaker"
}

resource "aws_appautoscaling_policy" "sm_policy" {
  count              = var.autoscaling_enabled ? 1 : 0
  name               = "${var.service_name}-tracking"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.sm_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.sm_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.sm_target[0].service_namespace

  dynamic "target_tracking_scaling_policy_configuration" {
    for_each = var.autoscaling_policies

    content {
      predefined_metric_specification {
        predefined_metric_type = target_tracking_scaling_policy_configuration.value.metric
      }
      target_value = target_tracking_scaling_policy_configuration.value.targetValue
    }
  }
}