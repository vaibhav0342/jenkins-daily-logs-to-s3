# jenkins-daily-logs-to-s3
This script checks for AWS CLI, iterates through all Jenkins job logs from today, and uploads them to an S3 bucket.

## 📦 Features

- Automatically scans all Jenkins jobs
- Uploads only today's build logs
- Stores logs in structured format in S3
- Simple to configure and schedule
- Works on any Jenkins instance with AWS CLI

---

## 🛠️ Prerequisites

- Jenkins installed (Linux server assumed)
- AWS CLI configured with access to your S3 bucket
- S3 bucket already created
- Permissions: `s3:PutObject` on the bucket
- `jq` installed (optional, only needed in advanced versions)

---

## 📁 Directory Structure

jenkins-log-uploader/ │ ├── upload_jenkins_logs_to_s3.sh # Main script └── README.md

---

## 🚀 Installation & Usage

### 1. Clone this repository

git clone https://github.com/vaibhav0342/jenkins-daily-logs-to-s3.git
cd jenkins-daily-logs-to-s3

2. Set variables in the script
Edit the top of upload_jenkins_logs_to_s3.sh:

JENKINS_HOME="/var/lib/jenkins"
S3_BUCKET="s3://your-s3-bucket-name"
Replace these with your Jenkins path and actual S3 bucket name.

3. Make the script executable
chmod +x upload_jenkins_logs_to_s3.sh

5. Run the script manually
./upload_jenkins_logs_to_s3.sh

7. Optional: Automate via cron
To run the script every night at 1 AM:

crontab -e
Add this line:

0 1 * * * /path/to/upload_jenkins_logs_to_s3.sh >> /var/log/jenkins_log_upload.log 2>&1

🧪 Example Output

📦 Starting upload of Jenkins logs for date: 2025-04-30
⬆️  Uploading log: my-job build #123
✅ Uploaded: s3://my-bucket/my-job-123.log
🎉 All done!
