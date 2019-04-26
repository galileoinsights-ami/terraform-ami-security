# Cloud Trail Properties

cloud_trail = {
  name  = "dev-ami-cloud_trail_events"
  s3_bucket = "dev-us-east-2-ami-cloud-trail-events"
}


# IAM Properties

iam_groups = {

  developers = {
    policies = ["arn:aws:iam::aws:policy/AmazonECS_FullAccess","arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  }

  dba = {
    policies = ["arn:aws:iam::aws:policy/AmazonRDSFullAccess","arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  }

  TFNetwork={
    policies = ["arn:aws:iam::aws:policy/AmazonVPCFullAccess","arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess","arn:aws:iam::731331465581:policy/TerraformS3BackendManagement"]
  }
}