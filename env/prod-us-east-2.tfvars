
# default AWS Tags
default_aws_tags = {
  Terraform = "true"
  Environment = "prod"
}

# Cloud Trail Properties

cloud_trail = {
  name  = "prod-ami-cloud_trail_events"
  s3_bucket = "prod-us-east-2-amicloudtrailevents"
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
  TFBastion={
    policies = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess","arn:aws:iam::aws:policy/AmazonRoute53FullAccess"]
  }
  TFRoute53={
    policies = ["arn:aws:iam::aws:policy/AmazonRoute53FullAccess"]
  }
  TFCertificateManager={
    policies = ["arn:aws:iam::aws:policy/AmazonRoute53FullAccess","arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess"]
  }
}

pgp_key = "keybase:owaism"

default_admin_ssh_public_key_base64 = <<PUBLIC_KEY
c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCQVFDc0lRSUpsZVNEcEF3WmRVN1N3
a0lUczdwUlJjN2s4RmtJZzBmYXZ5dW9KMHFEMktlaW44aEJ0R3F3TXo1U3N4OE5hcG5wREZ6Wjli
RVVoR25PdURaQnZvWWFidlZJSURaZ3RGRnpQcHJyaU14NnowRU5HcjAwcnhkdTk3QzFiN2lVdCtt
eUNDRU5abEhvWS9iWXlFUzhnRDZjUVh1MHdrMDM3L3VhNFY2d2dGSUJjWnBYYndvVFpUUGlPWjFT
M3RkNEUrL3NPNThMYm03Y1c5ZDBCQzVMSzJXdmVkVXQ0eHdqN2MvL0M1SURTbTErdWJOS2t5cWgx
VzllZm1LUWFzM3d1aGRrRXpFYWFGOEhvVTl2K2d3V1NObTlrYTRUdVhUU0xPUmZOTndBSHpJNDFu
eUc0UXViL0pZSUpaZExWa2dMT1JXeHlzTnJhbElSMmx4MDZ2Ymwgb3dhaXNAT3dhaXNNLU1hY2Jv
b2stUHJv
PUBLIC_KEY
