
# default AWS Tags
default_aws_tags = {
  Terraform = "true"
  Environment = "dev"
}

# Cloud Trail Properties

cloud_trail = {
  name  = "dev-ami-cloud_trail_events"
  s3_bucket = "dev-us-east-2-amicloudtrailevents"
}


# IAM Properties

iam_groups = {

  TFNetwork={
    policies = ["arn:aws:iam::aws:policy/AmazonVPCFullAccess","arn:aws:iam::aws:policy/AmazonRDSFullAccess"]
  }
  TFRds={
    policies = ["arn:aws:iam::aws:policy/AmazonRDSFullAccess"]
  }
  TFLoadBalancer={
    policies = ["arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"]
  }
}

pgp_key = "keybase:owaism"