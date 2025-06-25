# AWS Infrastructure with Terraform

This project provides a production-ready AWS infrastructure fully automated using Terraform. The infrastructure includes a secure network setup, EC2 instances, an Application Load Balancer (ALB), and a Lambda function that automates cleanup of unused EBS snapshots.

---

## 📦 Project Modules Overview

### 1. `network/`

**Purpose:** Create the VPC, subnets, and networking foundation.

**Includes:**

* VPC with CIDR block from variables
* Public and private subnets
* Route tables and internet gateway (for public subnets)

**Advantages:**

* Clearly separated network logic
* Scalable subnet configuration
* Suitable for multi-AZ deployments

---

### 2. `security/`

**Purpose:** Manage security groups and network ACLs.

**Includes:**

* Public security group for ALB (allow HTTP from 0.0.0.0/0)
* Private security group for EC2 (allow only from ALB SG)
* Optional NACLs for public/private subnets

**Advantages:**

* Secure EC2 instances (no direct public access)
* Centralized security logic
* Easy to audit and update

---

### 3. `ec2/`

**Purpose:** Deploy EC2 instances into private subnets.

**Includes:**

* Variable instance count
* AMI and instance type configurable
* Instances deployed in private subnets with a private SG
* Root EBS volumes tagged with `BackupPolicy = daily`

**Advantages:**

* EC2s isolated in private network
* Easy to scale horizontally
* Ready for use with ALB and backup automation

---

### 4. `loadbalancer/`

**Purpose:** Deploy a public-facing Application Load Balancer (ALB).

**Includes:**

* ALB in public subnets
* Listener on port 80 (HTTP)
* Target Group
* EC2 instances automatically registered using `for_each`

**Advantages:**

* Public entry point to internal EC2 apps
* Load-balanced traffic
* Decouples traffic from compute resources

---

### 5. `lambda_snapshot_cleaner/`

**Purpose:** Automate the cleanup of unused EBS snapshots.

**Includes:**

* Lambda function in Python
* IAM role with snapshot deletion permissions
* CloudWatch EventBridge rule (daily)
* Python logic: delete old snapshots (age > 7 days) not used by any EC2 volume and tagged `BackupPolicy = daily`

**Advantages:**

* Reduces storage cost
* Ensures clean snapshot lifecycle
* Fully automated, production-friendly solution

---

## ✅ Features

* Modular Terraform code
* Secure and scalable AWS architecture
* Clean separation of public and private layers
* Automated backup cleanup with Lambda
* Easy to adapt and extend

