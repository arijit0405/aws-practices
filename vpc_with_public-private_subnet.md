![image](https://github.com/user-attachments/assets/74329fb3-94cc-47b9-98e7-7ad9f9e2e286)

**AWS VPC + Auto Scaling + Bastion Host + Load Balancer Project Documentation**

---

**Project Objective:**
Deploy a Python web application securely on AWS using:

* VPC
* Public & Private Subnets
* Auto Scaling Group
* Bastion Host (Jump Server)
* Application Load Balancer
* Security Groups

---

**Step-by-Step Implementation:**

1. **VPC Setup:**

* Created a new VPC with CIDR: `10.0.0.0/16`.
* Selected 2 Availability Zones (AZ1 and AZ2) for high availability.

2. **Subnet Creation:**

* Created 4 Subnets:

  * Public Subnet AZ1: `10.0.1.0/24`
  * Public Subnet AZ2: `10.0.2.0/24`
  * Private Subnet AZ1: `10.0.3.0/24`
  * Private Subnet AZ2: `10.0.4.0/24`

3. **Internet Gateway:**

* Attached an Internet Gateway to the VPC.
* Configured Route Tables for public subnets to route 0.0.0.0/0 through Internet Gateway.

4. **Bastion Host Setup:**

* Launched a Bastion EC2 instance inside one of the Public Subnets.
* Assigned a Public IP to Bastion for SSH access from local machine.
* Configured Security Group to allow SSH (port 22) only from my IP.

5. **Key Pair Management:**

* Created a Key Pair locally.
* Copied the private key to Bastion Host using `scp`.
* From Bastion, used this key to SSH into instances inside Private Subnets.

6. **Auto Scaling Group Setup:**

* Created a Launch Template that installed Python and application dependencies via User Data.
* Launched an Auto Scaling Group in both Private Subnets across AZ1 & AZ2.
* The ASG handled automatic instance scaling.

7. **Python Web App Deployment:**

* SSH-ed into private instances through Bastion Host.
* Deployed a simple Python HTTP server (or Flask app) listening on port 80.

8. **Security Groups Configuration:**

* Bastion Host SG: Allow SSH (port 22) from my IP.
* Private EC2 SG: Allow SSH (port 22) only from Bastion Host SG.
* Load Balancer SG: Allow HTTP (port 80) from all (0.0.0.0/0).
* App Server SG: Allow HTTP (port 80) from Load Balancer SG only.

9. **Application Load Balancer Setup:**

* Created an ALB in Public Subnets.
* Registered the Auto Scaling Group instances in the Target Group.
* Configured health checks on port 80.
* Copied the ALB DNS name and accessed the application in browser.
* Verified traffic load balancing between the two instances.

---

**Outcome:**

* Fully secure production-grade AWS architecture.
* Web application deployed in private instances.
* Bastion Host used for secure administrative access.
* Load Balancer distributes traffic between instances.
* Auto Scaling ensures high availability.

---

**This project can be used as a showcase in my GitHub portfolio for AWS VPC & Scaling expertise.**
