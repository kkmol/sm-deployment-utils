resource "aws_sagemaker_model" "model" {
  name               = var.service_name
  execution_role_arn = aws_iam_role.sagemaker_execution.arn

  container {
    image          = "${var.ecr_clustering_byoc_image}@${var.ecr_clustering_byoc_image_hash}"
    model_data_url = "s3://${var.s3_model_artifact_bucket}/${var.s3_model_artifact_key}"
  }

  tags = local.common_tags
}