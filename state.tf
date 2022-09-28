# terraform {
#   backend "s3" {
#     bucket = "zuto-terraform-state-files"
#     key    = "services/rep-rate-sm-model-clearscore-refi/rep-rate-sm-model-clearscore-refi.tfstate"
#     region = "eu-west-2"
#     acl    = "bucket-owner-full-control"
#   }
# }