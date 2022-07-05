data "aws_iam_policy_document" "sagemaker_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "sagemaker_execution" {
  name               = "ZARRPSageMakerExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "sagemaker_execution" {
  role       = aws_iam_role.sagemaker_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

data "aws_iam_policy_document" "sagemaker_access" {
  statement {
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${var.s3_model_artifact_bucket}",
      "arn:aws:s3:::${var.s3_model_artifact_bucket}/*"
    ]
  }
}

resource "aws_iam_role_policy" "sagemaker_access" {
  name   = "AmazonS3ZARRPModelAccess"
  role   = aws_iam_role.sagemaker_execution.name
  policy = data.aws_iam_policy_document.sagemaker_access.json
}

