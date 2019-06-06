# Setting up AMI Security Components with Terraform

This is used to setup:

* Cloud Trail
* IAM User Groups
* IAM Policies
* AWS Keypairs

## Pre Requisites

1. **Pre-Commit Git Hook**: Install `pre-commit`. Visit https://pre-commit.com/. This is used to clean up the code before commiting to git.
2. **AWS Secret Scanner**: Install git-secrets. Visit https://github.com/awslabs/git-secrets. This is used to scan for aws credentials before a commit occurs.
3. **Terraform**: v0.11 Installed
4. Create IAM Custom Policy name `KeyImportPolicy` with the following content
	```
	{
	    "Version": "2012-10-17",
	    "Statement": [
	        {
	            "Sid": "SomeSid2934",
	            "Effect": "Allow",
	            "Action": "ec2:ImportKeyPair",
	            "Resource": "*"
	        }
	    ]
	}
	```
5. **AWS Setup**:
	* IAM Group: TFSecurity with the following managed policies
		* IAMFullAccess: arn:aws:iam::aws:policy/IAMFullAccess
		* AmazonS3FullAccess: arn:aws:iam::aws:policy/AmazonS3FullAccess
		* AWSCloudTrailFullAccess: arn:aws:iam::aws:policy/AWSCloudTrailFullAccess
		* AWSKeyManagementServicePowerUser: arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser
		* AmazonEC2FullAccess: arn:aws:iam::aws:policy/AmazonEC2FullAccess
		* Custom `KeyImportPolicy` created above
	* IAM User: TFSecurity with membership to the following IAM Group
		* TFSecurity
6. Create S3 bucket for storing Terraform Backend
7. Have a `setup.sh` file which exports all the environment varibles mentioned below in the root directory of this workspace

## Setup Environment Variable

Following Environment Variables need to be setup.

Variable Name | Description | Required? | Example Values
---|---|---|---
ENV | The environment of this AWS Setup | Yes | dev, prod
AWS_ACCESS_KEY_ID | AWS Access key of user `TFSecurity` | Yes |
AWS_SECRET_ACCESS_KEY | AWS Access Secret Key of user `TFSecurity` | Yes |
AWS_DEFAULT_REGION | The AWS Region to work with | Yes | us-east-2
TF_VAR_backend_s3_bucket_name | The S3 Terraform Backend Bucket | Yes | ami-terraform-configs

## Before Committing

1. Scan for Secrets in to be committed files

```
git secrets --scan -r
git secrets --scan --cached --no-index --untracked
```

## Executing Terraform

Execute `deploy.sh` file

```
./deploy.sh
```