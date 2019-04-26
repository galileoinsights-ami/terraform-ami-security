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
  #developers_iam_group_policies = "${lookup(var.iam_groups, "developers_policies")}"
  developers_iam_group = "${var.iam_groups["developers"]}"
  dba_iam_group = "${var.iam_groups["dba"]}"
  tf_network_iam_group = "${var.iam_groups["TFNetwork"]}"

  tfnetwork_group_policies = ["${local.tf_network_iam_group["policies"]}","${module.terraform_s3_backend_policy.arn}"]
}

data "aws_caller_identity" "current" {}


data "template_file" "cloudtrail_s3_policy" {
  template = "${file("templates/cloudtrail_s3_policy.tpl")}"
  vars {
    s3_bucket = "dev-us-east-2-ami-cloud-trail-events"
    aws_account_id = "${data.aws_caller_identity.current.account_id}"
  }
}

data "template_file" "terraform_s3_backend_policy" {
  template = "${file("templates/terraform_s3_backend_policy.tpl")}"
  vars {
    s3_bucket = "${var.backend_s3_bucket_name}"
  }
}


# Setting up cloud trail for this region

resource "aws_cloudtrail" "ami-cloud-trail" {
  name                          = "${lookup(var.cloud_trail, "name")}"
  s3_bucket_name                = "${aws_s3_bucket.cloud_trail_bucket.id}"
  s3_key_prefix                 = ""
  include_global_service_events = true
}

resource "aws_s3_bucket" "cloud_trail_bucket" {
  bucket        = "${local.cloud_trail_bucket_name}"
  force_destroy = true

  policy = "${data.template_file.cloudtrail_s3_policy.rendered}"
}

## Adding Custom Policies
module "terraform_s3_backend_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "TerraformS3BackendManagement"
  path        = "/"
  description = "Policy to allow manage S3 backend for Terraform"

  policy = "${data.template_file.terraform_s3_backend_policy.rendered}"
}

# Setting up IAM Groups

module "developers_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name = "developers"
  attach_iam_self_management_policy = true
  create_group = true
  custom_group_policy_arns = "${local.developers_iam_group["policies"]}"
}

module "dba_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name = "dba"
  attach_iam_self_management_policy = true
  create_group = true
  custom_group_policy_arns = "${local.dba_iam_group["policies"]}"
}

module "tfnetwork_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name = "TFNetwork"
  attach_iam_self_management_policy = true
  create_group = true
  custom_group_policy_arns = "${flatten(local.tfnetwork_group_policies)}"
}