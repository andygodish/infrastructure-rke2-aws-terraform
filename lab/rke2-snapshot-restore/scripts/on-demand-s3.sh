#!/bin/bash/

set -k

date=$(date '+%Y-%m-%d')

rke2 etcd-snapshot \
  --s3 \
  --s3-bucket=andyg-rfed \
  --s3-folder=rke2-snapshots \
  --name ${date}-<name> \
  --s3-region=us-gov-east-1 \
  --s3-access-key=${AWS_ACCESS_KEY_ID} \
  --s3-secret-key=${AWS_SECRET_ACCESS_KEY}

