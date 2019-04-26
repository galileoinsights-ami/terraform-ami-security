{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "TerraformS3BackendManagement2019042701",
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObjectVersion",
                "s3:GetObjectVersionTagging",
                "s3:ListBucket",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:GetBucketPolicy",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:PutObject",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectVersionForReplication",
                "s3:DeleteObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::${s3_bucket}"
        },
        {
            "Sid": "TerraformS3BackendManagement2019042702",
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        }
    ]
}