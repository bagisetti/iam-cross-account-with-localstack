#!/bin/bash

echo "Assuming cross account role..."

aws sts assume-role \
    --role-arn "arn:aws:iam::0000000000000:role/cross-account-access-role" \
    --role-session-name "TestSession" \
    --endpoint-url=http://localhost:4566 \
    > temp-creds.json

echo "Temporary credentials obtained. "
cat temp-creds.json