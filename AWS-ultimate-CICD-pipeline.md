![Screenshot 2025-06-18 220715](https://github.com/user-attachments/assets/3229434d-e30b-4c59-8e15-ca6f10daeb7c)

# 🚀 End-to-End AWS CI/CD Pipeline Project (Flask App → EC2)

## 📌 Project Overview
This project demonstrates how to implement a full CI/CD pipeline using AWS DevOps services to:

- Pull source code from **GitHub**
- Build with **AWS CodeBuild**
- Deploy to **EC2** using **AWS CodeDeploy** via **CodePipeline**

---

## 🧱 Tech Stack & Tools

| Layer         | Tool/Service                            |
|---------------|------------------------------------------|
| **Source**     | GitHub                                  |
| **CI**         | AWS CodeBuild                           |
| **CD**         | AWS CodeDeploy                          |
| **Orchestration** | AWS CodePipeline                   |
| **Hosting**    | EC2 (Amazon Linux 2)                    |
| **Language**   | Python (Flask)                          |

---

## 📁 File Structure

```
.
├── app.py                  # Flask app
├── Dockerfile              # Optional (not used for EC2)
├── requirements.txt        # Dependencies (Flask)
├── buildspec.yml           # Instructions for CodeBuild
├── appspec.yml             # Instructions for CodeDeploy
└── scripts/
    └── start.sh            # Script to start Flask app
```

---

## ✅ Step-by-Step Breakdown

### 🔸 1. Create Python Flask App

**app.py**
```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from AWS CI/CD Pipeline!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
```

---

### 🔸 2. Create `requirements.txt`

**requirements.txt**
```
Flask
```

---

### 🔸 3. Create `buildspec.yml`

Tells CodeBuild how to install dependencies and prepare build artifacts.

**buildspec.yml**
```yaml
version: 0.2

phases:
  install:
    runtime-versions:
      python: 3.9
    commands:
      - pip install -r requirements.txt

  build:
    commands:
      - echo "Build phase complete"

artifacts:
  files:
    - app.py
    - requirements.txt
    - appspec.yml
    - scripts/*
```

---

### 🔸 4. Create `appspec.yml` for CodeDeploy

**appspec.yml**
```yaml
version: 0.0
os: linux
files:
  - source: .
    destination: /home/ec2-user/flask-app

hooks:
  AfterInstall:
    - location: scripts/start.sh
      timeout: 300
      runas: ec2-user
```

---

### 🔸 5. Create `scripts/start.sh`

**scripts/start.sh**
```bash
#!/bin/bash
cd /home/ec2-user/flask-app
nohup python3 app.py > output.log 2>&1 &
```

Make it executable:
```bash
chmod +x scripts/start.sh
```

---

### 🔸 6. Launch EC2 Instance

**OS**: Amazon Linux 2

Install Python, Git, and CodeDeploy agent:
```bash
sudo yum update -y
sudo yum install python3 git -y
sudo yum install ruby -y
cd /home/ec2-user
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
```

---

### 🔸 7. IAM Roles Setup

| Service     | IAM Role Attachments                                                                 |
|-------------|----------------------------------------------------------------------------------------|
| EC2         | `AmazonEC2RoleforAWSCodeDeploy`                                                      |
| CodeDeploy  | `AWSCodeDeployRole`, `AmazonEC2FullAccess`, `AmazonS3ReadOnlyAccess`                 |
| CodeBuild   | `AWSCodeBuildAdminAccess`, `AmazonEC2ContainerRegistryReadOnly`, `AmazonS3ReadOnlyAccess` |

---

### 🔸 8. Create Application & Deployment Group in CodeDeploy

- **Application Name**: `flask-app`
- **Deployment Group**: `flask-deploy-group`
- **Deployment Type**: In-place
- **Environment Configuration**: Amazon EC2 instance
- **Target EC2 Instances**: Use tag (e.g., `Name=FlaskAppServer`)
- **Service Role**: Attach IAM role with `AWSCodeDeployRole`

---

### 🔸 9. Configure AWS CodePipeline

- **Source Stage**: Connect to GitHub repo (OAuth)
- **Build Stage**: Select your CodeBuild project
- **Deploy Stage**: Use CodeDeploy app `flask-app` and deployment group `flask-deploy-group`

---

## ✅ Final Pipeline

```text
GitHub → CodeBuild → CodeDeploy → EC2
```

---

## 🎉 Final Outcome

✅ You pushed code to GitHub  
✅ Pipeline automatically triggered  
✅ CodeBuild built and created artifacts  
✅ CodeDeploy copied and ran Flask on EC2  
✅ Application accessible via **EC2 Public DNS** on port **8000**

---

## 📸 Screenshot

> *(Add your own screenshot below of the AWS CodePipeline dashboard)*

```markdown
![Pipeline Screenshot](https://github.com/your-username/your-repo/assets/your-screenshot.png)
```

---

## 🙌 Congratulations!

You’ve successfully built and deployed a Flask application using a **fully automated CI/CD pipeline** on AWS!


