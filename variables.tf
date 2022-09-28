variable "service_name" {
  type        = string
  description = "Name of the SageMaker endpoint. Must be unique within account"
  default     = "zarrp-clearscore-refi"
}

variable "service_version" {
  type        = string
  description = "Version of the Service?"
  default     = "beta"
}

### Model


variable "ecr_clustering_byoc_image" {
  type        = string
  description = "ECR of SageMaker Clustering BYOC image"
  default     = "525344447431.dkr.ecr.eu-west-2.amazonaws.com/zklearn-clustering-sagemaker@sha256:3a1e25b9b13ba706cb0409b0f6b14cf583bed6af6072ee830c7ba4fa53251354"

}

variable "s3_model_artifact_bucket" {
  type        = string
  description = "S3 bucket storing the model & data capture"
  default     = "zuto-agg-rep-rate-prediction"
}

variable "s3_model_artifact_key" {
  type        = string
  description = "S3 key to the `model.tar.gz` that will be served"
  default     = "training/clearscore-refi/zarrp-clearscore-refi-20220822C-005-918727a6/output/model.tar.gz"
}



### Endpoint Configuration

variable "model_variant_name" {
  type        = string
  description = "Name of the model variant (used to track effects downstream)"
  default     = "csrefi-hpo-mae-20220823"
}

variable "instance_type" {
  type        = string
  description = "Size of AWS instance used to deploy model"
  default     = "ml.t2.medium"
}

variable "initial_instance_count" {
  type        = string
  description = "Number of instances that are created"
  default     = 1
}

variable "initial_variant_weights" {
  type        = string
  description = "Traffic Distribution among all of models specified"
  default     = 1
}

variable "s3_data_capture_uri" {
  type        = string
  description = "S3 location where captured data is stored"
  default     = "s3://zuto-agg-rep-rate-prediction/_test_data_capture/"
}

## Endpoint Autoscaling Policy

variable "autoscaling_enabled" {
  type        = bool
  description = "Enable Autoscaling of Endpoint instances flag"
  default     = false
}

variable "autoscaling_policies" {
  type = list(object({
    metric      = string
    targetValue = number
  }))
  description = "A list of autoscaling target tracking policies."
  default = [{
    metric      = "SageMakerVariantInvocationsPerInstance"
    targetValue = 60
  }]
}

variable "autoscaling_minimum_tasks" {
  type        = number
  description = "Minimum number of Endpoint instances"
  default     = 1
}

variable "autoscaling_maximum_tasks" {
  type        = number
  description = "Maximum number of Endpoint instances"
  default     = 3
}


variable "sns_alarm_topic_arn" {
  type        = string
  description = "ARN of SNS topic handling CloudWatch Alarms"
  default     = "arn:aws:sns:eu-west-2:331753892299:ml-monitoring"

}