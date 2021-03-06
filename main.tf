# Backend Initialization using command line

terraform {
  backend "s3" {
    key = "security.tfstate"
  }
}


# Initializing the provider

# Following properties need to be set for this to work
# export AWS_ACCESS_KEY_ID="anaccesskey"
# export AWS_SECRET_ACCESS_KEY="asecretkey"
# export AWS_DEFAULT_REGION="us-west-2"
# terraform plan
provider "aws" {}

output "sample" {
  value = "${lookup(var.cloud_trail, "s3_bucket")}"
}

locals {

  cloud_trail_bucket_name = "${lookup(var.cloud_trail, "s3_bucket")}"
  tfnetwork_iam_group = "${var.iam_groups["TFNetwork"]}"
  tfrds_iam_group = "${var.iam_groups["TFRds"]}"
  tfloadbalancer_iam_group = "${var.iam_groups["TFLoadBalancer"]}"
  tfbastion_iam_group = "${var.iam_groups["TFBastion"]}"
  tfroute53_iam_group = "${var.iam_groups["TFRoute53"]}"
  tfcertificatemanager_iam_group = "${var.iam_groups["TFCertificateManager"]}"
}


data "aws_caller_identity" "current" {}

## Template to create the S3 policy for cloud trail
data "template_file" "cloudtrail_s3_policy" {
  template = "${file("templates/cloudtrail_s3_policy.tpl")}"
  vars {
    s3_bucket = "${local.cloud_trail_bucket_name}"
    aws_account_id = "${data.aws_caller_identity.current.account_id}"
  }
}



## IAM Policy to be attached all terraform Users to manage remote\backend state
data "template_file" "terraform_s3_backend_policy" {
  template = "${file("templates/terraform_s3_backend_policy.tpl")}"
  vars {
    s3_bucket = "${var.backend_s3_bucket_name}"
  }
}

## IAM Policy to allow administration of Security Groups
data "template_file" "security_group_administrator_policy" {
  template = "${file("templates/security_group_administrator_policy.tpl")}"
}


/*******************************

Cloud Trail Setup

*******************************/

## Setup bucket for Cloud Trail
resource "aws_s3_bucket" "cloud_trail_bucket" {
  bucket        = "${local.cloud_trail_bucket_name}"
  force_destroy = true

  policy = "${data.template_file.cloudtrail_s3_policy.rendered}"

  tags = "${var.default_aws_tags}"
}

## Activate cloud trail
resource "aws_cloudtrail" "ami-cloud-trail" {
  name                          = "${lookup(var.cloud_trail, "name")}"
  s3_bucket_name                = "${aws_s3_bucket.cloud_trail_bucket.id}"
  s3_key_prefix                 = ""
  include_global_service_events = true
  tags = "${var.default_aws_tags}"
}

/*******************************

Setup up IAM Groups and Users

********************************/

## Adding Custom Policy so that all Terraforom users can access and commit to
## remote state in S3
module "terraform_s3_backend_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "0.4.0"

  name        = "TerraformS3BackendManagement"
  path        = "/"
  description = "Policy to allow manage S3 backend for Terraform"

  policy = "${data.template_file.terraform_s3_backend_policy.rendered}"
}

## Adding Custom Policy To allow managment of Security Groups
module "security_group_administrator_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "0.4.0"

  name        = "SecurityGroupAdministratorPolicy"
  path        = "/"
  description = "Policy to allow managment of Security Groups for Terraform"

  policy = "${data.template_file.security_group_administrator_policy.rendered}"
}



## Creates a key pair to be used for spining up EC2 instances
resource "aws_key_pair" "infrastructure_admin" {
  key_name   = "infrastructure-admin"
  public_key = "${base64decode(var.default_admin_ssh_public_key_base64)}"
}


## Setting the TFNetwork IAM Group
module "tfnetwork_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "0.4.0"

  name = "TFNetwork"
  attach_iam_self_management_policy = false
  create_group = true
  custom_group_policy_arns = "${local.tfnetwork_iam_group["policies"]}"

  group_users = [
    "${module.tfnetwork_user.this_iam_user_name}"
  ]

}

## Attach the custome policy to TFNetwork IAM Group
resource "aws_iam_group_policy_attachment" "tfnetwork_group_attach" {
  group      = "${module.tfnetwork_group.this_group_name}"
  policy_arn = "${module.terraform_s3_backend_policy.arn}"
}

module "tfnetwork_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "0.4.0"

  name = "TFNetwork"
  create_user = true
  create_iam_user_login_profile = false
  create_iam_access_key = true
  force_destroy = true
  path = "/tf/"
  pgp_key = "${var.pgp_key}"

}



## Setting the TFRds IAM Group
module "tfrds_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "0.4.0"

  name = "TFRds"
  attach_iam_self_management_policy = false
  create_group = true
  custom_group_policy_arns = "${local.tfrds_iam_group["policies"]}"

  group_users = [
    "${module.tfrds_user.this_iam_user_name}"
  ]

}

## Attach the custom policy to TFRds IAM Group
resource "aws_iam_group_policy_attachment" "tfrds_group_attach_s3_backend" {
  group      = "${module.tfrds_group.this_group_name}"
  policy_arn = "${module.terraform_s3_backend_policy.arn}"
}

resource "aws_iam_group_policy_attachment" "tfrds_group_attach_security_group_policy" {
  group      = "${module.tfrds_group.this_group_name}"
  policy_arn = "${module.security_group_administrator_policy.arn}"
}

module "tfrds_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "0.4.0"

  name = "TFRds"
  create_user = true
  create_iam_user_login_profile = false
  create_iam_access_key = true
  force_destroy = true
  path = "/tf/"
  pgp_key = "${var.pgp_key}"

}


## Setting the TFLoadlancer IAM Group
module "tfloadbalancer_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "0.4.0"

  name = "TFLoadBalancer"
  attach_iam_self_management_policy = false
  create_group = true
  custom_group_policy_arns = "${local.tfloadbalancer_iam_group["policies"]}"

  group_users = [
    "${module.tfloadbalancer_user.this_iam_user_name}"
  ]

}

## Attach the custom policy to TFLoadbalancer IAM Group
resource "aws_iam_group_policy_attachment" "tfloadbalancer_group_attach" {
  group      = "${module.tfloadbalancer_group.this_group_name}"
  policy_arn = "${module.terraform_s3_backend_policy.arn}"
}

module "tfloadbalancer_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "0.4.0"

  name = "TFLoadBalancer"
  create_user = true
  create_iam_user_login_profile = false
  create_iam_access_key = true
  force_destroy = true
  path = "/tf/"
  pgp_key = "${var.pgp_key}"

}


## Setting the TFBastion IAM Group
module "tfbastion_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "0.4.0"

  name = "TFBastion"
  attach_iam_self_management_policy = false
  create_group = true
  custom_group_policy_arns = "${local.tfbastion_iam_group["policies"]}"

  group_users = [
    "${module.tfbastion_user.this_iam_user_name}"
  ]

}

## Attach the custom policy to TFBastion IAM Group
resource "aws_iam_group_policy_attachment" "tfbastion_group_attach" {
  group      = "${module.tfbastion_group.this_group_name}"
  policy_arn = "${module.terraform_s3_backend_policy.arn}"
}

module "tfbastion_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "0.4.0"

  name = "TFBastion"
  create_user = true
  create_iam_user_login_profile = false
  create_iam_access_key = true
  force_destroy = true
  path = "/tf/"
  pgp_key = "${var.pgp_key}"

}


## Setting the TFRoute53 IAM Group
module "tfroute53_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "0.4.0"

  name = "TFRoute53"
  attach_iam_self_management_policy = false
  create_group = true
  custom_group_policy_arns = "${local.tfroute53_iam_group["policies"]}"

  group_users = [
    "${module.tfroute53_user.this_iam_user_name}"
  ]

}

## Attach the custom policy to TFRoute53 IAM Group
resource "aws_iam_group_policy_attachment" "tfroute53_group_attach" {
  group      = "${module.tfroute53_group.this_group_name}"
  policy_arn = "${module.terraform_s3_backend_policy.arn}"
}

module "tfroute53_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "0.4.0"

  name = "TFRoute53"
  create_user = true
  create_iam_user_login_profile = false
  create_iam_access_key = true
  force_destroy = true
  path = "/tf/"
  pgp_key = "${var.pgp_key}"

}

## Setting the TFCertificateManager IAM Group
module "tfcertificatemanager_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "0.4.0"

  name = "TFCertificateManager"
  attach_iam_self_management_policy = false
  create_group = true
  custom_group_policy_arns = "${local.tfcertificatemanager_iam_group["policies"]}"

  group_users = [
    "${module.tfcertificatemanager_user.this_iam_user_name}"
  ]

}

## Attach the custom policy to TFCertificateManager IAM Group
resource "aws_iam_group_policy_attachment" "tfcertificatemanager_group_attach" {
  group      = "${module.tfcertificatemanager_group.this_group_name}"
  policy_arn = "${module.terraform_s3_backend_policy.arn}"
}

module "tfcertificatemanager_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "0.4.0"

  name = "TFCertificateManager"
  create_user = true
  create_iam_user_login_profile = false
  create_iam_access_key = true
  force_destroy = true
  path = "/tf/"
  pgp_key = "${var.pgp_key}"

}