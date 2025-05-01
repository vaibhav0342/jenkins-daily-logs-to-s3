#!/bin/bash

# =====================
# Author : vaibhav upare
# Mail : vaibhavupare757@gmail.com
# Script: upload_jenkins_logs_to_s3.sh
# Description: Uploads today's Jenkins job logs to an S3 bucket
# =====================

# === CONFIGURE THESE VARIABLES ===
JENKINS_HOME="/var/lib/jenkins"                  # Jenkins home directory
S3_BUCKET="s3://your-s3-bucket-name"             # Replace with your actual S3 bucket
DATE=$(date +%Y-%m-%d)                           # Get today's date
# ==================================

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it to proceed."
    exit 1
fi

echo "📦 Starting upload of Jenkins logs for date: $DATE"

# Loop through all Jenkins jobs
for job_dir in "$JENKINS_HOME/jobs/"*/; do
    job_name=$(basename "$job_dir")

    # Loop through all builds for each job
    for build_dir in "$job_dir/builds/"*/; do
        build_number=$(basename "$build_dir")
        log_file="$build_dir/log"

        # Check if log file exists and is from today
        if [ -f "$log_file" ] && [ "$(date -r "$log_file" +%Y-%m-%d)" == "$DATE" ]; then
            s3_log_path="$S3_BUCKET/$job_name-$build_number.log"
            echo "⬆️  Uploading log: $job_name build #$build_number"

            # Upload to S3
            aws s3 cp "$log_file" "$s3_log_path" --only-show-errors

            if [ $? -eq 0 ]; then
                echo "✅ Uploaded: $s3_log_path"
            else
                echo "❌ Failed to upload: $job_name/$build_number"
            fi
        fi
    done
done

echo "🎉 All done!"
