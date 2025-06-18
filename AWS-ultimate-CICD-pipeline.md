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

├── app.py # Flask app
├── Dockerfile # Optional (not used for EC2)
├── requirements.txt # Dependencies (Flask)
├── buildspec.yml # Instructions for CodeBuild
├── appspec.yml # Instructions for CodeDeploy
└── scripts/
└── start.sh # Script to start Flask app


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

🔸 2. Create requirements.txt
requirements.txt

 3. Create buildspec.yml
Tells CodeBuild how to install dependencies and prepare build artifacts.

buildspec.yml

 4. Create appspec.yml for CodeDeploy


