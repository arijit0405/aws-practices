
# 📘 AWS CodeCommit – Complete Guide

## ✅ What is AWS CodeCommit?
AWS CodeCommit is a **fully managed Git-based** source control service that lets you privately store and manage your code, binaries, and other assets in the cloud.

It is similar to services like GitHub, GitLab, or Bitbucket but runs on AWS and integrates tightly with other AWS services.

---

## 🔑 Key Features

| Feature           | Description |
|------------------|-------------|
| Fully Managed     | No need to host, scale, or maintain a Git server |
| Secure            | Uses AWS IAM for fine-grained access control, encrypted at rest and transit |
| Scalable          | Scales automatically to meet your needs |
| Integration       | Works seamlessly with AWS CodePipeline, CodeBuild, Lambda, etc. |
| Git-Compatible    | Use Git commands (clone, push, pull, etc.) like any other Git repo |
| High Availability | Designed for durability and availability |

---

## 🛠️ How It Works (Flow)

1. Developer pushes code to **CodeCommit repository**.
2. **AWS IAM** handles authentication and permissions.
3. Trigger downstream services like:
   - **CodeBuild** for building the code
   - **CodePipeline** for CI/CD
   - **CodeDeploy** for deployment

---

## 🔒 Security

- **Encryption**: Repositories are encrypted at rest using AWS KMS.
- **IAM Policies**: Control who can read/write to the repo.
- **AWS Secrets Manager**: Can be used for storing Git credentials for automation.

---

## 📦 CodeCommit vs GitHub

| Feature         | AWS CodeCommit | GitHub |
|----------------|----------------|--------|
| Hosting         | Fully managed AWS | GitHub Cloud or Enterprise |
| Access Control  | AWS IAM         | GitHub roles and PATs |
| Integration     | Seamless with AWS services | GitHub Actions or others |
| Cost            | Free up to 5 users | Free plan available |
| CI/CD           | CodePipeline, CodeBuild | GitHub Actions, others |

---

## 🚀 Basic Workflow

### 1. Create a Repo
```bash
aws codecommit create-repository --repository-name MyRepo
```

### 2. Clone Repo
```bash
git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/MyRepo
```

### 3. Push Code
```bash
git add .
git commit -m "Initial commit"
git push origin main
```

### 4. Set up Triggers (Optional)
Integrate with Lambda, SNS, or build jobs when code is pushed.

---

## 🧪 Real-World Use Case

- Developers push to CodeCommit.
- A trigger starts a **CodeBuild** job to test and build code.
- **CodePipeline** deploys it to EC2, ECS, or Lambda.
- Review PRs via UI or CLI.

---

## ⚙️ Setup Requirements

- Git installed
- AWS CLI configured (`aws configure`)
- IAM user/role with permissions
- Git credentials helper for HTTPS or SSH

---

## 👩‍💻 CodeCommit IAM Permissions Example

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull",
        "codecommit:GitPush"
      ],
      "Resource": "arn:aws:codecommit:us-east-1:123456789012:MyRepo"
    }
  ]
}
```

---

## 🎯 Best Practices

- Enable **notifications/triggers** for build/deploy.
- Use **branches** and **pull requests** for collaboration.
- Integrate with **CodePipeline** for CI/CD.
- Keep repositories **private and protected**.
