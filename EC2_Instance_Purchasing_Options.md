# 🧠 EC2 Instance Purchasing Options

Amazon EC2 provides a variety of purchasing options tailored to different workloads, flexibility, and cost considerations. Here's a detailed breakdown:

---

## ✅ 1. On-Demand Instances

- **Description**: Pay for compute capacity by the second (Linux) or hour (Windows) without long-term commitments.
- **Use Cases**: Short-term, unpredictable workloads or for testing/development environments.
- **Pros**:
  - No upfront payment
  - Scales easily with demand
- **Cons**:
  - Highest cost per hour

> Ideal for temporary or unpredictable workloads.

---

## 💰 2. Reserved Instances (RIs)

- **Description**: Commit to 1-year or 3-year terms for a significant discount.
- **Types**:
  - **Standard** – up to 75% savings, no modification allowed
  - **Convertible** – up to 54% savings, can change instance attributes
- **Payment Options**:
  - All upfront
  - Partial upfront
  - No upfront

> Best for steady-state usage, like web servers or databases.

---

## 🔁 3. Savings Plans

- **Description**: Commitment to a consistent usage (measured in $/hr) for 1 or 3 years.
- **Types**:
  - **Compute Savings Plan**: Applies to any EC2 instance, Fargate, Lambda
  - **EC2 Instance Savings Plan**: Region-specific, instance family

> More flexible than RIs and still offers significant savings.

---

## 🎯 4. Spot Instances

- **Description**: Purchase unused EC2 capacity at up to 90% discount.
- **Use Cases**: Stateless, fault-tolerant, or flexible workloads such as batch processing, data analysis.
- **Cons**:
  - Can be interrupted by AWS with a 2-minute warning

> Great for cost savings if interruptions are acceptable.

---

## 🚀 5. Dedicated Hosts

- **Description**: A physical server dedicated for your use.
- **Use Cases**:
  - License-bound workloads (e.g., Microsoft, Oracle)
  - Regulatory or compliance needs

---

## 🛡️ 6. Dedicated Instances

- **Description**: Instances that run on hardware dedicated to a single customer.
- **Difference from Hosts**: You don’t have visibility/control over host-level resources.

---

## 🔄 7. Capacity Reservations

- **Description**: Reserve EC2 capacity in a specific Availability Zone.
- **Use Case**: Ensuring availability during spikes or critical deployments.

---

## 📊 Summary Comparison

| Option               | Cost       | Commitment     | Best For                            |
|----------------------|------------|----------------|-------------------------------------|
| On-Demand            | 💸 High     | ❌ None         | Short-term, testing                 |
| Reserved Instances   | 💰 Medium   | ✅ 1–3 years    | Predictable, long-term workloads    |
| Savings Plans        | 💰 Medium   | ✅ 1–3 years    | Flexible, consistent usage          |
| Spot Instances       | 💸 Lowest   | ❌ None         | Batch jobs, stateless workloads     |
| Dedicated Hosts      | 💸 High     | ✅ Optional     | Licensing compliance                |
| Dedicated Instances  | 💸 High     | ✅ Optional     | Isolation without host-level control|
| Capacity Reservations| 💸 High     | ✅ Optional     | Guaranteed AZ-level availability    |

---

*Generated on July 22, 2025*
