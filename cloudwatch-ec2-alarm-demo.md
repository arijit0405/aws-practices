
![Screenshot 2025-06-19 141541](https://github.com/user-attachments/assets/26769243-8776-42c6-9871-2eb8f026b15a)


# 🧠 AWS CloudWatch EC2 Alarm Demo – Project Documentation

## 📌 Objective
To monitor CPU utilization of an EC2 instance using **AWS CloudWatch**, and trigger an **email alarm** when CPU usage exceeds 50%.

---

## 🔧 Tools & Services Used
- Amazon EC2
- AWS CloudWatch (Metrics, Alarms)
- Amazon SNS (for email alert)

---

## 📝 CloudWatch: Quick Overview

**AWS CloudWatch** is a monitoring and observability service. It collects data such as:

- 📊 Metrics (e.g., CPUUtilization, DiskReadOps)
- 📄 Logs (application logs)
- 🚨 Alarms (triggers on conditions)
- 🧠 Events (respond to state changes)

In this project, we use:
- **CloudWatch Metrics** to track EC2 CPU usage.
- **CloudWatch Alarm** to notify when usage exceeds threshold.
- **SNS** to send email alerts.

---
![Screenshot 2025-06-19 142331](https://github.com/user-attachments/assets/ccff6be4-1063-464d-8f3b-a345e2e95f89)

## 🔨 Steps Performed

### 1. **Created EC2 Instance**
- Launched an EC2 instance named `cloudwatch-demo`.
- Chose Amazon Linux or Ubuntu as AMI.
- Allowed **port 22 (SSH)** and ensured **IAM role with CloudWatch access** (optional if using agent).

---

### 2. **Wrote CPU Spike Script**
Inside the EC2 instance:
```bash
sudo yum update -y
sudo yum install python3 -y

