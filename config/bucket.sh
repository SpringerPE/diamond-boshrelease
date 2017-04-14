#!/usr/bin/env bash
set -e

# Create the bucket for blobs and setup public read access
BUCKET=$(cat final.yml | awk '/bucket_name:/{ print $2 }')

s3cmd mb "s3://${BUCKET}"
s3cmd setacl "s3://${BUCKET}"  --acl-public --recursive

