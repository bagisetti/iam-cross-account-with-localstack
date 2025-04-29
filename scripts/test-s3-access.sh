#!/bin/bash

AWS_ACCESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' temp-creds.json)
AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' temp-creds.json)
AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' temp-creds.json)
AWS_REGION="us-east-1"

# Export environment variables for this shell
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN
export AWS_REGION

# Confirm values
echo "Using temporary credentials:"
echo "AccessKeyId: $AWS_ACCESS_KEY_ID"
echo "SecretAccessKey: (hidden)"
echo "SessionToken: (hidden)"


# aws s3 ls s3://cross-account-bucket \
#     --region $AWS_REGION \
#     --endpoint-url=http://localhost:4566 \
#     --access-key $AWS_ACCESS_KEY_ID \
#     --secret-key $AWS_SECRET_ACCESS_KEY \
#     --session-token $AWS_SESSION_TOKEN

echo "Listing S3 buckets with assumed credentials..."
aws s3 ls s3://cross-account-bucket/ \
    --endpoint-url=http://localhost:4566

