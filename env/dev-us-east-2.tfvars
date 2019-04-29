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
}

pgp_key = "keybase:owaism"