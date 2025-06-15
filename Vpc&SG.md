AWS Hands-On Progress Log - Arijit Chakraborty

Date: 15/6/2025

-------------------------------------------------

✔️ **AWS Services Practiced:**
- EC2
- IAM
- VPC
- Security Groups
- NACL (Network Access Control List)

-------------------------------------------------

✔️ **AWS Project 1: EC2 + VPC + Python Application**

1️⃣ **Created IAM User:**
   - Logged into AWS Console
   - Created a new IAM User
   - Assigned necessary permissions (EC2FullAccess, VPCFullAccess, etc.)
   - Configured AWS Access Keys for programmatic access

2️⃣ **Created EC2 Instance:**
   - Selected appropriate AMI (e.g., Amazon Linux 2 or Ubuntu)
   - Configured instance type (t2.micro for free tier)
   - Generated a new Key Pair for SSH login
   - Launched the EC2 instance

3️⃣ **Created a new VPC (Virtual Private Cloud):**
   - Configured CIDR Block
   - Created subnets within the VPC
   - Configured route tables and associated them with subnets
   - Attached Internet Gateway to allow internet access

4️⃣ **Created Security Group for EC2:**
   - Allowed inbound rules:
      - SSH (Port 22) for remote login
      - HTTP (Port 80) for web app access
      - Custom TCP (Port 8000) for my Python app
   - Restricted source IP as required

5️⃣ **SSH into EC2 Instance:**
   - Used private key (.pem file) to SSH from local machine into EC2 instance

6️⃣ **Deployed Python Application:**
   - Installed Python and required dependencies
   - Created a simple Python application that listens on port 8000
   - Started the application on the instance

7️⃣ **Accessed the Application:**
   - Edited security group to allow inbound traffic on port 8000
   - Accessed the running Python app from browser using:
     - http://<public-ip>:8000

-------------------------------------------------

✔️ **Learned Concepts Practiced:**
- IAM User creation and policy management
- EC2 provisioning and key pair usage
- VPC setup (CIDR, Subnet, IGW, Route Tables)
- Security Groups vs NACLs
- Deploying app and exposing to internet securely

-------------------------------------------------

END OF LOG
