
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
c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFDQVFEcXQ3NjlXaE1P
SzJXckdwVjV5Ryt5VVVjeEg4K2NRU05NMVB6VmJIbkZLRkc5eU5rRmNTeEQyZ2ZX
d2s3UUhmV0w3NU94NEhJM0FjYVNWQUxCTDJaL2RpMjkwTGdiVHRlUk9UcnhRK3Jy
cC81RUszSTQzZHNQd3R1K044SmtubWo5NXcrTEdsNkJudWJzaERndjNHcktOQmF4
ZVp4WlM0MkxsRXViOW5hU0w2dVMwT2pmZ0tuNzc2eURqNDYzNVN0MEJtSUxqWXhG
UjJ1UExOQnNBSXlPMHNydGJhWDVaZFlkTkVhelRzb3ZJN3ZMa3dYMWdXdXNOVk9z
N0dIWlFacjFncGZCby9kRXN6K3l4S2xpb05Dekg2UFFrWjVydUkzVXpGUjJIYXB4
dTJ0cHBwMS83aGdORjdJMGNza0lGRjdaRFJFdGlrcWdBcmY3UFdsNldqM0VEVm5U
UHNud1ZVdmR0cVJDMDY2NHdMa3U0NlFiUUtjWmFnd2hod2dDOXJEOXpwZTNHNm9U
RlI1cnpKaklSdUY3elFSb0hjanVtanYzcTVGaGlVL1RlRmZRSGRBbjVLNjRONER2
c0tVZEhsVDkvQ3A5ckhjNWlmRVppN3c4blRhbDIyUUo2VGtLOUxOTG8vN3pnK1la
Z3E2OUxRVk1VZTZhcmNuYnRESDFhSlVqVmZad0NyV2grVFZWckZxSGhRTGdYOXFr
MjJHb050Z3BYa2RpSUUrMGhiMVRNSFhNNmFzZWJqR3NvUTc4NSsvV2JUdWUzS2Uz
NDNLbTJQMVNWT0Ivb1oyZUJydzFreGEzUTdicGVwWFFYbGh6dEJ3ZWszZ2NTWHhu
K3M1UjRyMDl2N1ZQMjhYQkEyNVU4amloencwYmdKaG5vamgrNlVYVzRRamdoUXNG
Nnc9PSBvd2Fpc0BPd2Fpc00tTWFjYm9vay1Qcm8K
PUBLIC_KEY
