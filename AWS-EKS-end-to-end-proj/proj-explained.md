AWS EKS End-to-End Project: 2048 Game Deployment
This project demonstrates how to deploy a containerized 2048 game application on Amazon Elastic Kubernetes Service (EKS) using AWS Fargate and expose it to the internet with an Application Load Balancer (ALB) Controller.
Project Structure

2048-app-deploy-ingress.md: Details the deployment and ingress configuration for the 2048 game application.
README.md: This file, providing an overview and step-by-step explanation of the project.
alb-controller-add-on.md: Explains the setup and usage of the ALB Controller as an add-on for Kubernetes.
configure-oidc-connector.md: Describes the configuration of the OIDC connector for IAM roles.
installing-eks.md: Outlines the installation and setup process for the EKS cluster.
prerequisites.md: Lists the necessary tools and configurations required before starting the project.
sample-app.md: Contains details about the sample 2048 game application being deployed.

Prerequisites
Before starting, ensure the following tools are installed and configured:

AWS CLI: Configured with aws configure to manage AWS services.
Use: Enables interaction with AWS services via the command line.


eksctl: A command-line tool for creating and managing EKS clusters.
Use: Simplifies EKS cluster creation and management.


kubectl: Kubernetes command-line tool for interacting with the cluster.
Use: Allows deployment and management of applications on Kubernetes.


helm: Package manager for Kubernetes.
Use: Facilitates the installation of Kubernetes applications like the ALB Controller.



Steps to Deploy the 2048 Game
1. Create EKS Cluster using eksctl
eksctl create cluster --name my-application-cluster --region ap-south-1


Use: Creates an EKS cluster with a VPC, subnets, internet gateway, security groups, route tables, IAM roles, and an optional node group. This process takes about 15 minutes and sets up the foundational infrastructure.

2. Update Kubeconfig to Access the Cluster
aws eks update-kubeconfig --name my-application-cluster --region ap-south-1


Use: Updates your local kubeconfig file to allow kubectl to communicate with the newly created EKS cluster.

3. Create a Fargate Profile for the Namespace
eksctl create fargateprofile \
  --cluster demo-cluster \
  --region us-east-1 \
  --name alb-sample-app \
  --namespace game-2048


Use: Configures a Fargate profile to run pods serverlessly in the game-2048 namespace, leveraging AWS Fargate for cost efficiency and scalability.

4. Deploy the 2048 App (YAML Manifest)
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/examples/2048/2048_full.yaml


Use: Deploys the 2048 game application, creating a deployment, namespace (game-2048), service, and ingress resources that will later be managed by the ALB.

5. Associate IAM OIDC Provider
eksctl utils associate-iam-oidc-provider \
  --cluster demo-cluster \
  --approve


Use: Associates an IAM OIDC provider with the EKS cluster, enabling Kubernetes service accounts to assume IAM roles for secure AWS resource access.

6. Create IAM Policy for ALB Controller
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json


Use: Creates an IAM policy that defines the permissions the ALB Controller needs to manage AWS resources like load balancers and target groups.

7. Create IAM Service Account
eksctl create iamserviceaccount \
  --cluster=demo-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<your-aws-account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve


Use: Sets up an IAM service account for the ALB Controller, linking it to the IAM role and policy for secure AWS resource management.

8. Deploy AWS ALB Controller
Add Helm Chart Repo
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks


Use: Adds and updates the Helm repository containing the ALB Controller chart for installation.

Install Controller
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=demo-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=ap-south-1 \
  --set vpcId=<your-vpc-id>


Use: Installs the ALB Controller using Helm, configuring it to work with the EKS cluster and VPC.

9. Verify the Controller is Running
kubectl get deployment -n kube-system aws-load-balancer-controller


Use: Checks the status of the ALB Controller deployment to ensure it is running correctly.

10. Access Your 2048 App

Steps: Retrieve the ALB DNS name created by the ALB Ingress Controller and open it in your browser.
Use: Allows you to play the 2048 game hosted on the EKS cluster via a public endpoint.

Outcome

Successfully set up an EKS cluster.
Deployed the 2048 game application using Fargate.
Configured IAM OIDC and custom roles for secure access.
Integrated the ALB Ingress Controller for public access.
Accessed the application via a public ALB endpoint.

🎉 Congratulations on completing the deployment!
