# AWS EKS End-to-End Project: 2048 Game Deployment

This project demonstrates how to deploy a containerized **2048 game application** on **Amazon Elastic Kubernetes Service (EKS)** using **AWS Fargate** and expose it to the internet with an **Application Load Balancer (ALB) Controller**.

---

## 📁 Project Structure

- `2048-app-deploy-ingress.md`: Deployment and ingress configuration for the 2048 game application.
- `README.md`: This file, providing an overview and step-by-step explanation of the project.
- `alb-controller-add-on.md`: Setup and usage of the ALB Controller as an add-on for Kubernetes.
- `configure-oidc-connector.md`: Configuration of the OIDC connector for IAM roles.
- `installing-eks.md`: Installation and setup process for the EKS cluster.
- `prerequisites.md`: Necessary tools and configurations required before starting.
- `sample-app.md`: Details about the sample 2048 game application being deployed.

---

## ✅ Prerequisites

Ensure the following tools are installed and configured:

| Tool       | Purpose                                                        |
|------------|----------------------------------------------------------------|
| **AWS CLI** | Interact with AWS services (`aws configure`)                 |
| **eksctl**  | Create and manage EKS clusters                                |
| **kubectl** | Interact with Kubernetes cluster                              |
| **helm**    | Package manager for Kubernetes apps (e.g., ALB Controller)   |

---

## 🚀 Steps to Deploy the 2048 Game

### 1. Create EKS Cluster Using `eksctl`

```bash
eksctl create cluster --name my-application-cluster --region ap-south-1
```

> Creates an EKS cluster with VPC, subnets, IAM roles, node groups, etc. (~15 min)

---

### 2. Update Kubeconfig to Access the Cluster

```bash
aws eks update-kubeconfig --name my-application-cluster --region ap-south-1
```

> Updates `~/.kube/config` to allow `kubectl` to talk to the cluster.

---

### 3. Create Fargate Profile for the Namespace

```bash
eksctl create fargateprofile \
  --cluster demo-cluster \
  --region us-east-1 \
  --name alb-sample-app \
  --namespace game-2048
```

> Configures Fargate to run pods in `game-2048` namespace serverlessly.

---

### 4. Deploy the 2048 App (YAML Manifest)

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/examples/2048/2048_full.yaml
```

> Deploys namespace, deployment, service, and ingress.

---

### 5. Associate IAM OIDC Provider

```bash
eksctl utils associate-iam-oidc-provider \
  --cluster demo-cluster \
  --approve
```

> Associates IAM OIDC for secure access via IAM roles for service accounts.

---

### 6. Create IAM Policy for ALB Controller

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json
```

> Creates IAM policy with ALB permissions.

---

### 7. Create IAM Service Account

```bash
eksctl create iamserviceaccount \
  --cluster=demo-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<your-aws-account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

> Links service account with IAM role and policy.

---

### 8. Deploy AWS ALB Controller

#### Add Helm Repo

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
```

#### Install Controller

```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=demo-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=ap-south-1 \
  --set vpcId=<your-vpc-id>
```

> Installs ALB Controller with your cluster and VPC.

---

### 9. Verify the Controller is Running

```bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```

> Ensures ALB controller is deployed and running.

---

### 10. Access Your 2048 App

- Retrieve the ALB DNS name created by the controller:
  ```bash
  kubectl get ingress -n game-2048
  ```
- Open the `ADDRESS` in your browser.

> Play the 2048 game via public endpoint!

---

## ✅ Outcome

- ✔️ EKS cluster created and configured
- ✔️ 2048 game deployed using AWS Fargate
- ✔️ IAM OIDC and custom policies configured
- ✔️ ALB Ingress Controller integrated
- ✔️ Public access enabled via ALB

---

🎉 **Congratulations! You've successfully deployed the 2048 app on AWS EKS using Fargate and ALB!**
