# ⚖️ AWS Load Balancers – Overview

AWS Elastic Load Balancing (ELB) automatically distributes incoming traffic across multiple targets (like EC2, ECS, IPs, or Lambda functions) for high availability, fault tolerance, and scalability.

## 🧩 Types of AWS Load Balancers

| Load Balancer | Full Name               | Layer         | Use Case                             |
|---------------|--------------------------|---------------|---------------------------------------|
| ALB           | Application Load Balancer| Layer 7 (HTTP/HTTPS) | Web apps, REST APIs              |
| NLB           | Network Load Balancer    | Layer 4 (TCP/UDP)   | High-performance, low-latency apps |
| GWLB          | Gateway Load Balancer    | Layer 3/4 (IP)      | Security appliances like firewalls, IPS/IDS |

## 1️⃣ Application Load Balancer (ALB)

### ✅ Best For:
- HTTP/HTTPS web traffic
- Microservices / Containers
- Routing based on content

### 💡 Features:
- Layer 7 (Application Layer)
- Path-based routing (e.g., `/api` → service A, `/user` → service B)
- Host-based routing (e.g., `api.example.com` → service)
- WebSocket support
- Integrates with ECS, EKS, Lambda

## 2️⃣ Network Load Balancer (NLB)

### ✅ Best For:
- Ultra-fast performance
- TCP/UDP traffic
- Real-time apps or low latency needs

### 💡 Features:
- Layer 4 (Transport Layer)
- Handles millions of requests per second
- Preserves the source IP address
- Works with static IP addresses or Elastic IPs

## 3️⃣ Gateway Load Balancer (GWLB)

### ✅ Best For:
- Deploying and scaling security appliances
- Centralizing third-party tools (firewalls, traffic inspection, etc.)

### 💡 Features:
- Operates at Layer 3/4
- Routes traffic to virtual appliances using GENEVE encapsulation
- Great for centralized security architectures

## 🆚 Comparison Table

| Feature                | ALB             | NLB             | GWLB                         |
|------------------------|------------------|------------------|-------------------------------|
| Layer                  | 7 (Application)   | 4 (Transport)     | 3/4 (Network/Gateway)         |
| Protocols              | HTTP, HTTPS, WebSocket | TCP, UDP, TLS     | IP                            |
| Use Case               | Web apps, APIs   | Gaming, chat, real-time apps | Firewalls, deep packet inspection |
| Target Types           | EC2, Lambda, IP, ECS | EC2, IP, ECS       | Elastic Network Interfaces (ENIs) |
| Sticky Sessions        | Supported (via cookies) | Not supported     | Not applicable                |
| SSL Termination        | Supported         | Supported         | Not applicable                |
| Source IP Preservation | Not preserved     | Preserved         | Preserved                     |
| Pricing                | Medium            | Low               | Higher (due to complexity)    |
| WebSocket Support      | ✅                | ❌                | ❌                            |

## 🛠️ When to Use What?

| Scenario                                | Use This |
|-----------------------------------------|----------|
| You need advanced request routing (path/host) | ALB      |
| Your app requires ultra-low latency     | NLB      |
| You need to deploy firewalls/security appliances | GWLB     |
| You're using containers (ECS/EKS)       | ALB or NLB |
| You want to inspect or filter traffic   | GWLB     |

## 🔗 Common Integrations

| Service         | Load Balancer    |
|------------------|------------------|
| ECS / Fargate    | ALB / NLB        |
| Kubernetes (EKS) | ALB (via ALB Controller) |
| Lambda           | ALB              |
| VPC Security     | GWLB             |
