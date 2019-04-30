
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

default_admin_ssh_public_key_base64 = <<PUBLIC_KEY
c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFDQVFEUk41TDVEWnRT
elBYamNoRVZmNCswZXdkMDh1bU5CdWt1Wkh4TFBDa3UzNi80dzNNV3cycncxTVVp
cmo1d0tCc1BLS2VGMU9YYzQ0TGxVMi9VMkdvejNCM1RlTFVIZERxQUF6T1FOZmd1
ektiQ3cvaVNiZVczM1pTcmVjNnY0T0NhemR4WlpsL2ZjV01HYVlZNGJYVVQ0Nklr
eS9VUmtIb3JaTUlxSEtuTjZ6Qk9wb0tBelpWbHJUdWxrbm5pQXlsc0ZKNHNDZ3dM
MjFQYkRUbm5LWXVpQ3p1MjJDMnI4L3UySnZxL1hKbE5HN1ZhY2pqS1JsOTZDS2t4
Y0tHaGxLYmd2RGE1ZVBVTkdDZVBEVFk4S1VvWXJXb3NEazV4dDREdWo5cW1ZQVFZ
QStSMkxLaEtmWE1JOWdBRFRGVENCWmZubm9LM1ErSkFiMHJDRS9IUGV0eDZzRjBZ
eDdpcHN5ZDJMeFd6L3l4QXlVVDJyWW90VTFja3lWZ3d1MW9uOUtzWFd0SE1jeEl3
a25qK3FublZ1MVNwbHFXU1ZMUlJMMXFEWTFUa0NiS0dLR3ZObG1FSUpGODZYL3dY
S2Q1STNEV0JCckNEOHBJWk9uYlNlOTZHbkJBUlZHM1p2UER4ak5JaWVSZXcrNE12
M2xyaFNRY2RWbmNSRWdwVWg5ZEZUb2Racmd3dEFnN1g2aFNuVnQxc1Y2TmIrbEtI
MmNTSk1OeThYNGJZK1hOdHNWWk1PYnRhaHo1YTJqVE5VcnBQZ2E1aEhMbFU0SG1D
WjdKbTBhaDhkUzY0NXk3Q3NRRUxuWXRuSGcwRDlUOUFOb2M1Q3JaS1VSUTIyL1Vi
clJteThkdWlGWEROV1RVb0I0a2NNMXFJTDNObmtoNW1WWVNaRHpMWmRRUXVkc2I4
Vnc9PSBvd2Fpc20K
PUBLIC_KEY
