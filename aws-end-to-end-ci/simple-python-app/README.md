![image](https://github.com/user-attachments/assets/83a6076e-62b2-4c66-8974-5b2cd0e4077a)

🚀 AWS CI Pipeline Project – Python Flask App
📌 Overview
This project demonstrates how to build a CI pipeline using AWS CodeBuild and AWS CodePipeline to automatically build a simple Flask Hello World app whenever a code change is pushed to the repository.

🧱 Project Structure

├── app.py               # Simple Flask Hello World app
├── Dockerfile           # Dockerfile to containerize the app
├── requirements.txt     # Python dependencies (Flask)
├── buildspec.yml        # Build instructions for AWS CodeBuild

✅ Tools & Services Used
AWS CodeCommit (or GitHub)

AWS CodeBuild

AWS CodePipeline

IAM Roles with SSM permissions

Docker (optional for image build)

🛠️ Step-by-Step Process
1. Create the Python Flask Application
app.py
2. Create a requirements.txt File
3. Create a Dockerfile
4. Create a buildspec.yml File
5.  Configure IAM Permissions
Create an IAM role for CodeBuild and attach:

AmazonSSMFullAccess

AmazonS3ReadOnlyAccess

AWSCodeBuildAdminAccess

✅ You faced permission errors initially which were fixed by ensuring these permissions were correctly attached.

6. Create a CodeBuild Project
Select source as GitHub or CodeCommit

Select environment as managed (Ubuntu + Python)

Point to the buildspec.yml

Assign the IAM role

Start build

✅ Build was successful after adjusting permissions on 5th attempt.
7. Create a CodePipeline
Source stage: GitHub/CodeCommit

Build stage: Attach CodeBuild project

No deploy stage (optional in CI only)

✅ You linked the pipeline to trigger builds on every code push.

🎉 Outcome
Build runs automatically on every Git push.

Flask app is built using CodeBuild.

CI is fully automated on AWS.

📌 Learnings
IAM roles and permissions are key in AWS CI/CD.

buildspec.yml must be properly structured.

Docker is optional unless you want to push to ECR.

Pipeline triggers can be automated on push events.

