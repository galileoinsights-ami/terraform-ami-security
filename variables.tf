
variable "cloud_trail" {
  type = "map"
  description = "Contains all cloud trail properites"
  default = {}
}

variable "iam_groups" {
  type = "map"
  description = "Contains all IAM Groups to be created"
  default = {}
}

variable "backend_s3_bucket_name" {
  description = "Name of the backend S3 bucket"
  default = "backend_s3_bucket_name"
}