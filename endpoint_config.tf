resource "aws_sagemaker_endpoint_configuration" "endpoint_config" {
  name = var.service_name

  production_variants {
    variant_name           = var.model_variant_name
    model_name             = aws_sagemaker_model.model.name
    initial_instance_count = var.initial_instance_count
    instance_type          = var.instance_type
  }

  # data_capture_config {
  #   capture_options {
  #     capture_mode = var.data_capture_mode
  #   }
  #   enable_capture              = var.data_capture_flag
  #   initial_sampling_percentage = var.data_capture_initial_sampling_percentage
  #   destination_s3_uri          = var.s3_data_capture_uri
  # }

  tags = local.common_tags
}