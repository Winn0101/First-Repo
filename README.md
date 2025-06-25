# Terraform AWS Project: EC2, S3 Buckets, DynamoDB, Networking & Route-53

This project uses **Terraform** to provision basic AWS infrastructure, including:

- A custom **Virtual Private Cloud (VPC)**
- An **EC2 instance**
- **Two S3 buckets**, created using the `for_each` expression
- A **DynamoDB table**,
- A **Network system that includes VPC, Network interface, Internet Gateway, Security Groups etc**
- An **A record, CName and TXT records in a Hosted Private Zone**

It’s a great starting point for learning Infrastructure as Code (IaC) with Terraform.

---

## 📦 What This Project Does

The Terraform scripts will:

1. Configure AWS as the provider.
2. Creates a custom VPC with a `172.0.0.0/16` CIDR block.
3. Launches a `t2.micro` EC2 instance using a specific AMI.
4. Dynamically provisions two uniquely tagged S3 buckets using `for_each`.
5. Create a DynamoDB table along with 2 EC2 instances with the 'count' expression and a security group
6. Create a EC2 instance, VPC, Subnet, Internet Gateway, Security Group (SSH(22)& HTTP(80)) with an ingress and egress rule and one S3 bucket which uses a 'depends_on' expression on the virtual machine.
7. A VPC, route-53 private zone, an A record, CNAME and TXT record

---

## 🧱 File Structure

- **Terraform v1.0+**
- **AWS CLI**
- **AWS Free Tier account**

---

## ⚙️ Getting Started

### Prerequisites

- [Install Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Install & Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) with your `default` profile

### Steps to Deploy

```bash
# Step 1: Clone the repository
git clone https://github.com/Winn0101/First-Repo.git
cd First-Repo

# Step 2: Initialize Terraform
terraform init

# Step 3: Preview the changes
terraform plan

# Step 4: Apply the configuration
terraform apply
