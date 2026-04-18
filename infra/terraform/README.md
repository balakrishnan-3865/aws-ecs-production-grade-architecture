# Terraform Infrastructure

## Overview

This directory contains a simplified Terraform-based implementation of the infrastructure used to deploy the Spring Boot application on AWS.

It mirrors the architecture described in the root README, but focuses specifically on how the infrastructure is defined and managed using Terraform.

---

## Scope

This is a curated reference implementation intended to demonstrate infrastructure design and Terraform usage.

Included:
- VPC with public and private subnets
- Internet Gateway and route tables
- Application Load Balancer (ALB)
- ECS (Fargate) service and task definition

Excluded:
- Full IAM policies and role configurations
- Secrets Manager and Parameter Store setup
- Environment-specific configurations and optimizations

---

## Structure
```
terraform/
├── provider.tf
├── variables.tf
├── main.tf
├── outputs.tf
│
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── alb/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── ecs/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```
---

## Key Concepts Demonstrated

- Modular Terraform design (separation of networking and compute layers)
- Infrastructure as Code (IaC) for reproducible environments
- Passing outputs between modules (e.g., VPC → ECS, ALB → ECS)
- ECS task definition with environment variables and external dependencies
- Load balancing and service exposure via ALB

---

## Key Learnings

- Difference between RDS endpoint and address and its impact on application connectivity
- Handling existing AWS resources when introducing Terraform (state conflicts and imports)
- ECS service behavior during deployments (requires explicit redeploy for new images)
- Importance of avoiding resource drift when mixing manual provisioning and Terraform
- Networking considerations for private deployments (subnets, routing, and service access)

---

## Notes

This directory is intended for demonstration purposes.

The full working setup includes additional configurations, integrations, and safeguards that are not shown here to keep the example focused and easy to understand.