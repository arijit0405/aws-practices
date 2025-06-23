# 🔐 What Is Secret Management?

Secret Management refers to the secure storage, access, and lifecycle management of sensitive information such as:

- API keys
- Passwords
- Database credentials
- SSH keys
- Tokens and certificates

---

# 🔧 Tools AWS Provides for Secret Management

## 1. AWS Secrets Manager

A fully managed service to store, rotate, and access secrets securely.

### ✨ Key Features:
- Automatic secret rotation
- Built-in integration with RDS, Redshift, DocumentDB
- IAM-based fine-grained access control
- Audit logging with CloudTrail
- Encryption at rest using KMS

### 📌 Use Cases:
- Store database credentials
- Store 3rd party API keys
- Auto-rotate credentials

### 💡 Example Use:
```python
import boto3
import json

def get_secret():
    client = boto3.client('secretsmanager')
    response = client.get_secret_value(SecretId='MySecret')
    secret = json.loads(response['SecretString'])
    return secret['username'], secret['password']
```

---

## 2. AWS Systems Manager (SSM) Parameter Store

A free alternative to Secrets Manager (with some limitations).

### ✨ Key Features:
- Store values as plain text or encrypted strings
- Supports hierarchical storage (e.g., /prod/db/password)
- Integrated with IAM, EC2, Lambda
- Supports KMS encryption

### 📌 Use Cases:
- Store application config values and secrets
- CI/CD variable management
- Works great in automation scripts (Ansible, Terraform)

### 💡 Example:
```bash
aws ssm put-parameter --name "/prod/db/password" \
  --value "mysecret123" --type "SecureString" --key-id "alias/aws/ssm"
```

---

# 🔐 Secrets Rotation

Secrets Manager supports automatic rotation using Lambda functions.

- You can set rotation schedules (e.g., every 30 days).
- Great for compliance and security hygiene.

---

# ⚖️ Secrets Manager vs Parameter Store

| Feature                 | Secrets Manager | Parameter Store        |
|------------------------|-----------------|------------------------|
| Designed For           | Secrets         | Config + secrets       |
| Auto-Rotation          | ✅ Yes          | ❌ No                  |
| Fine-Grained IAM Access| ✅ Yes          | ✅ Yes                 |
| Pricing                | 💸 Paid         | 🆓 Free (up to 10k params) |
| Encryption with KMS    | ✅ Yes          | ✅ Yes                 |
| Max Value Size         | 64KB            | 4KB                    |

---

# 🔒 Best Practices for Secret Management

- Never hardcode secrets in code or Git repositories.
- Use IAM roles to allow apps to access secrets securely.
- Use Secrets Manager for secrets that need rotation.
- Use Parameter Store for configuration values or free-tier secret use.
- Enable CloudTrail logs to track who accessed what and when.
- Rotate secrets regularly.
- Limit access via least privilege principle.

---

# 🛠️ Integration with DevOps Tools

- **Terraform**: Manages secrets in both Secrets Manager and Parameter Store.
- **Ansible**: Uses Parameter Store in playbooks.
- **CI/CD (CodeBuild, Jenkins)**: Inject secrets via IAM roles at runtime.
