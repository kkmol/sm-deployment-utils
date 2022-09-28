resource "aws_cloudformation_stack" "inference" {
  name = "${var.service_name}-stack"

  parameters = {
    ServiceName = var.service_name

    ModelAVariantName = var.model_variant_name
    ModelAImage       = var.ecr_clustering_byoc_image
    ModelADataUrl     = "s3://${var.s3_model_artifact_bucket}/${var.s3_model_artifact_key}"

    ModelBVariantName  = "${var.model_variant_name}-clone"
    ModelBImage        = var.ecr_clustering_byoc_image
    ModelBDataUrl      = "s3://${var.s3_model_artifact_bucket}/${var.s3_model_artifact_key}"
    ModelExecutionRole = aws_iam_role.sagemaker_execution.arn,

    InstanceType         = var.instance_type
    InitialInstanceCount = var.initial_instance_count
    DataCaptureFlag      = terraform.workspace == "prod" ? "true" : "false"
    DataCaptureS3Uri     = var.s3_data_capture_uri

    CreationDate = local.current_datetime
  }

  template_body = file("${path.module}/cloudformation.json")

  depends_on = [
    aws_cloudwatch_metric_alarm.invocation_4xx_errors_average,
    aws_cloudwatch_metric_alarm.invocation_5xx_errors,
    aws_iam_role.sagemaker_execution
  ]
}

