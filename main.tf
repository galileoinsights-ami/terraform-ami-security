# Backend Initialization using command line

terraform {
  backend "s3" {
    key = "security.tstate"
  }
}


# Initializing the provider

# Following properties need to be set for this to work
# export AWS_ACCESS_KEY_ID="anaccesskey"
# export AWS_SECRET_ACCESS_KEY="asecretkey"
# export AWS_DEFAULT_REGION="us-west-2"
# terraform plan
provider "aws" {}


locals {

  cloud_trail_bucket_name = "${lookup(var.cloud_trail, "s3_bucket")}"
  tfnetwork_iam_group = "${var.iam_groups["TFNetwork"]}"
  tfrds_iam_group = "${var.iam_groups["TFRds"]}"
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
resource "aws_iam_group_policy_attachment" "tfrds_group_attach" {
  group      = "${module.tfrds_group.this_group_name}"
  policy_arn = "${module.terraform_s3_backend_policy.arn}"
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