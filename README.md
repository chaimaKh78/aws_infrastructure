# AWS Infrastructure Automation (Terraform)

Automated production‑ready AWS infrastructure built with Terraform, including secure networking, autoscaling EC2 deployment, Application Load Balancer (ALB), and automated snapshot cleanup using AWS Lambda. This repository demonstrates real‑world DevOps practices and infrastructure automation.

---

## 🧠 Project Summary

This repository showcases an end‑to‑end AWS infrastructure setup using Infrastructure as Code (IaC).  
It includes:

- **Modular Terraform configuration** to provision AWS resources
- **Secure and scalable architecture** with VPC, subnets, security groups
- **Load balanced compute layer** using EC2 behind an ALB
- **Automation** with Lambda function for cleanup of unused snapshots
- Separation of infrastructure concerns for clarity and reusability

This project acts as a **professional-level DevOps portfolio piece** to demonstrate cloud engineering capabilities.

---

## 🏗️ Architecture Overview

Below is a simplified visual of how components relate:

```text id="aws_arch"
                   ┌───────────────┐
                   │   AWS VPC     │
                   │ (networking)  │
                   └───────┬───────┘
                           │
              ┌────────────┼───────────────┐
              ▼            ▼               ▼
        Public Subnets  Private Subnets   Lambda (Snapshot Cleaner)
            (ALB)           (EC2)                  |
              │               │                     |
              └────┬──────────┴──────────┬──────────┘
                   │                     │
                  ALB           [Auto Scaling EC2 Fleet]
---

## 📌 Key Features

* **Infrastructure Provisioning:** Create AWS network, compute, and load balancer resources using Terraform with reusable modules.
* **Security:** Infrastructure setup follows secure design (private EC2 subnets + controlled security groups).
* **Automation:** Lambda function automatically cleans up outdated EBS snapshots to reduce cost.
* **Modularity:** Code organized into network, security, compute, and automation modules for easier collaboration and reuse.
* **Production‑ready:** Designed with separation of concerns suitable for staging/production environments.

---

## 🛠️ Tech Stack

| Category               | Tools                         |
| ---------------------- | ----------------------------- |
| Infrastructure as Code | Terraform                     |
| Cloud Provider         | Amazon Web Services           |
| Automation             | AWS Lambda                    |
| Load Balancing         | AWS Application Load Balancer |
| Security               | VPC, Security Groups          |

*(Add AWS resource ARN examples or outputs if available.)*

---

## 📋 Modules Breakdown

**1. `network/`** — Virtual Private Cloud (VPC) with public and private subnets
**2. `security/`** — Security group rules and network ACLs
**3. `ec2/`** — Provision EC2 instances in private subnets
**4. `loadbalancer/`** — Public ALB and target groups
**5. `lambda_snapshot_cleaner/`** — Automated cleanup of unused EBS snapshots using Lambda and EventBridge rule

Each module encapsulates a distinct part of the infrastructure for modular reuse and clarity.

---

## 📥 How to Deploy

### Prerequisites

* AWS CLI configured with proper credentials
* Terraform installed (v1.x+)
* Access to an AWS account with necessary permissions

### Deployment Steps

1. Clone the repository:

```bash
git clone https://github.com/chaimaKh78/aws_infrastructure.git
cd aws_infrastructure
```

2. Initialize Terraform:

```bash
terraform init
```

3. Review the execution plan:

```bash
terraform plan
```

4. Apply infrastructure changes:

```bash
terraform apply
```

5. Validate deployed resources in AWS Console / via CLI.

---


## 🚀 Learning Outcomes

This project demonstrates:

* Real‑world AWS IaC using Terraform
* Modular infrastructure design for production
* Cloud automation with Lambda functions
* Best practices in secure networking and load balancing

---

## 🏷️ GitHub Topics

```
aws, terraform, devops, infrastructure-as-code, cloud-engineering, automation
```

---

## 📌 Notes

This repository simulates **production‑like infrastructure work** and is a portfolio piece suitable for cloud engineering, DevOps, and SRE roles.

---


