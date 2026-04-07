# Architecture Overview

This project demonstrates a production-style AWS deployment of a containerized Spring Boot application using ECS, Application Load Balancer, and RDS within a VPC.

---

## High-Level Architecture

- Users access the application over the internet
- Traffic enters through an Internet Gateway
- Requests are routed to an Application Load Balancer (ALB)
- ALB forwards traffic to ECS tasks running in private subnets
- ECS tasks communicate with an RDS database hosted in private subnets

---

## Architecture Diagram

![Architecture Diagram](../infra/diagrams/architecture-01.jpg)

---

## Components

### 1. VPC (Virtual Private Cloud)
- Isolated network environment
- Segmented into public and private subnets across multiple availability zones

---

### 2. Public Subnets
- Host the Application Load Balancer
- Connected to the Internet Gateway
- Allow inbound HTTP/HTTPS traffic from the internet

---

### 3. Private Subnets
- Host ECS tasks and RDS database
- No direct internet access
- Improves security by isolating internal services

---

### 4. Application Load Balancer (ALB)
- Entry point for all external traffic
- Distributes incoming requests across ECS tasks
- Performs health checks on targets

---

### 5. ECS (Elastic Container Service)
- Runs the containerized Spring Boot application
- Deployed as a service across multiple subnets for high availability
- Integrated with ALB for traffic routing

---

### 6. RDS (Relational Database Service)
- Hosted in private subnets
- Not publicly accessible
- Only accessible from ECS tasks via security group rules

### 7. CloudWatch Logs
- Captures application logs from ECS containers
- Used for debugging, monitoring, and basic observability

---

## Traffic Flow

1. Client sends request over the internet
2. Request reaches Internet Gateway
3. Routed to Application Load Balancer in public subnet
4. ALB forwards request to ECS task in private subnet
5. ECS task processes request and queries RDS if needed
6. Response flows back through ALB to client

---

## Networking & Security

- **Security Groups**
  - ALB allows inbound traffic from internet (HTTP/HTTPS)
  - ECS allows traffic only from ALB
  - RDS allows traffic only from ECS

- **Subnet Isolation**
  - Public subnets: internet-facing components
  - Private subnets: application and database layers

- **Database Security**
  - No public access to RDS
  - Access restricted via internal networking

---

## High Availability Considerations

- Resources distributed across multiple subnets (AZs)
- ALB routes traffic only to healthy ECS tasks
- ECS service ensures the configured number of tasks remain running (self-healing behavior)

---

## Limitations (Current Setup)

- Manual infrastructure provisioning
- No auto-scaling configured
- Cost not optimized (NAT Gateway, RDS uptime)

---

## Future Improvements

- Infrastructure as Code using Terraform
- Auto-scaling ECS services
- Cost optimization strategies