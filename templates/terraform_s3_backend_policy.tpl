{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "TerraformS3BackendManagement2019042701",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": "arn:aws:s3:::${s3_bucket}"
        },
        {
            "Sid": "TerraformS3BackendManagement2019042702",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload"
            ],
            "Resource": "arn:aws:s3:::${s3_bucket}/*"
        },
        {
            "Sid": "TerraformS3BackendManagement2019042703",
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        }
    ]
}