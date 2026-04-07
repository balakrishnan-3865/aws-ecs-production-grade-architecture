# Challenges & Learnings

This project involved setting up a production-style AWS architecture with private subnets, which introduced several networking and access-related challenges.

---

## 1. ECS Access to Container Images in ECR

**Problem**  
After pushing the Docker image to Amazon ECR, ECS tasks in private subnets were unable to pull the image.

**Cause**  
ECS tasks did not have internet access, and there was no configured path to reach ECR endpoints.

**Solution**  
Instead of introducing a NAT Gateway, VPC Interface Endpoints were created for ECR:
- com.amazonaws.<region>.ecr.api
- com.amazonaws.<region>.ecr.dkr

Security groups were configured to allow ECS tasks to communicate with these endpoints.

**Learning**  
- ECS tasks in private subnets require explicit network access to AWS services  
- VPC endpoints can replace NAT Gateway for accessing AWS-managed services securely and cost-effectively  

---

## 2. ECR Image Pull Dependency on S3

**Problem**  
Even after configuring access to ECR, ECS tasks still failed to pull container images.

**Cause**  
ECR stores image layers in Amazon S3. While ECR endpoints were accessible, S3 access was not configured.

**Solution**  
A VPC Gateway Endpoint for S3 was added:
- com.amazonaws.<region>.s3

This allowed ECS tasks to retrieve image layers without requiring internet access.

**Learning**  
- ECR depends on S3 under the hood for image storage  
- Accessing ECR privately requires both ECR and S3 connectivity  
- Understanding hidden service dependencies is critical in cloud architectures  

---

## 3. Access to Secrets Manager and Parameter Store

**Problem**  
Application configuration using Secrets Manager and Parameter Store was not accessible from ECS tasks.

**Cause**  
Private subnets lacked connectivity to these AWS services.

**Solution**  
VPC Interface Endpoints were created for:
- AWS Secrets Manager
- AWS Systems Manager (Parameter Store)

Security group rules were updated to allow ECS tasks to communicate with these endpoints.

**Learning**  
- Each AWS service requires explicit connectivity when operating in private subnets  
- VPC endpoints enable secure, private communication without exposing resources to the internet  

---

## 4. ALB Health Check Configuration for Spring Boot

**Problem**  
ECS tasks were running, but the Application Load Balancer marked them as unhealthy and did not route traffic.

**Cause**  
By default, the ALB target group performs health checks on the root path (`/`).  
The Spring Boot application exposes health status via the Actuator endpoint (`/actuator/health`), so the default check was failing.

**Solution**  
Updated the target group health check configuration to use:

- **Health check path:** `/actuator/health`

Ensured that:
- The Actuator dependency was enabled in the application
- The endpoint was accessible from within the VPC

The listener then correctly routed traffic only to healthy ECS tasks.

**Learning**  
- ALB health checks must align with application-specific endpoints  
- Default configurations may not work for frameworks like Spring Boot  
- Proper health checks are critical for reliable traffic routing and availability  

---

## Key Takeaway

Most challenges were related to networking and service connectivity in a private VPC setup.

Resolving these issues significantly improved understanding of:
- AWS networking (subnets, routing, endpoints)
- Service-to-service communication
- Trade-offs between NAT Gateway and VPC Endpoints
- Configuring right health checks are critical for reliable traffic routing and availability  

These challenges reinforced the importance of designing cloud systems with both security and connectivity in mind.





