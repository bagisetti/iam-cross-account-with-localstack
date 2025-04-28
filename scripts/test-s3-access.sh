#!bin/bash

source temp-creds.json

AWS_ACCSESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' temp-creds.json)
AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' temp-creds.json)
AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' temp-creds.json)
AWS_REGION="us-east-1"

echo "Listing S3 buckets with assumed credentials..."
aws s3 ls s3://cross-account-bucket \
    --region $AWS_REGION \
    --endpoint-url=http://localhost:4566 \
    --access-key $AWS_ACCSESS_KEY_ID \
    --secret-key $AWS_SECRET_ACCESS_KEY \
    --session-token $AWS_SESSION_TOKEN

