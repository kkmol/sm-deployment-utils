### Model
variable "service_name" {
  type        = string
  description = "Name of the SageMaker endpoint. Must be unique within account"
  default     = "zarrp-clearscore-pipeline"
}

variable "service_version" {
  type        = string
  description = "Version of the Service?"
  default     = "beta"
}

variable "ecr_clustering_byoc_image" {
  type        = string
  description = "ECR of SageMaker Clustering BYOC image"
  default     = "525344447431.dkr.ecr.eu-west-2.amazonaws.com/zklearn-clustering-sagemaker"
}

variable "ecr_clustering_byoc_image_hash" {
  type        = string
  description = "Hash of the desired SageMaker Clustering BYOC image version"
  default     = "sha256:1826a70b53297c8664b188a99ee522b77bca3a00da391467d197635f383af7c4"
}

variable "s3_model_artifact_bucket" {
  type        = string
  description = "S3 bucket storing the model & data capture"
  default     = "zuto-agg-rep-rate-prediction"
}

variable "s3_model_artifact_key" {
  type        = string
  description = "S3 key to the `model.tar.gz` that will be served"
  default     = "training/clearscore-refi/zarrp-training-clearscore-2022-07-29-14-27-00-779/output/model.tar.gz"
}



### Endpoint Configuration

variable "model_variant_name" {
  type        = string
  description = "Name of the model variant (used to track effects downstream)"
  default     = "2022-07-29"
}

variable "instance_type" {
  type        = string
  description = "Size of AWS instance used to deploy model"
  default     = "ml.t2.medium"
}

variable "initial_instance_count" {
  type        = number
  description = "Number of instances that are created"
  default     = 1
}

variable "data_capture_flag" {
  type        = bool
  description = "Flag to enable data capture"
  default     = true
}

variable "data_capture_mode" {
  type        = string
  description = "Mode of data capture. Incoming data or outgoing data"
  default     = "Input"
}

variable "data_capture_initial_sampling_percentage" {
  type        = number
  description = "Portion of data to capture. Between 0 and 100 %"
  default     = 25
}

variable "s3_data_capture_uri" {
  type        = string
  description = "S3 location where captured data is stored"
  default     = "s3://zuto-agg-rep-rate-prediction/_test_data_capture/"
}


### Endpoint 

variable "traffic_routing_configuration_type" {
  type        = string
  description = "Traffic Rerouting Type"
  default     = "ALL_AT_ONCE"
}

variable "traffic_routing_configuration_wait" {
  type        = number
  description = ""
  default     = 100
}

variable "blue_green_max_execution" {
  type        = number
  description = ""
  default     = 600
}

variable "blue_green_time_until_termination" {
  type        = number
  description = "value"
  default     = 300
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