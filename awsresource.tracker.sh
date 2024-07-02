#!/bin/bash
# Author: Shaik Thaheer
# Date: 09/10/2023
# Version: 02 (Improved)

set -ex  # Exit immediately on errors

# Define output directory (optional, adjust as needed)
OUTPUT_DIR="awsreports"  # Defining the output directory name
mkdir -p "$OUTPUT_DIR" || true  # Creating directory

# AWS Resource Usage Reports
# S3 Buckets
aws s3 ls > "$OUTPUT_DIR/s3_buckets.txt" 2>&1  # Capture standard output and errors
echo "S3 bucket list saved to s3_buckets.txt"

# EC2 Instances
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' > "$OUTPUT_DIR/ec2_instances.txt" 2>&1
echo "EC2 instance IDs saved to ec2_instances.txt"

# Lambda Functions
aws lambda list-functions | jq '.Functions[].FunctionName' > "$OUTPUT_DIR/lambda_functions.txt" 2>&1
echo "Lambda function names saved to lambda_functions.txt"

# IAM Users
aws iam list-users | jq '.Users[].UserName' > "$OUTPUT_DIR/iam_users.txt" 2>&1
echo "IAM user names saved to iam_users.txt"
