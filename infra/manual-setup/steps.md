# Manual Setup (Phase 1)

Infrastructure was provisioned using AWS CLI in a staged manner.  
Each stage was validated before proceeding to the next.

---

## Execution Order

1. **Network Setup**
   - VPC, subnets, route tables, Internet Gateway

2. **Security Configuration**
   - Security groups for ALB, ECS, and RDS

3. **Database Setup**
   - RDS instance in private subnet

4. **Secrets Management**
   - AWS Secrets Manager / Parameter Store configuration

5. **Container Registry**
   - ECR repository creation and image push

6. **Load Balancer**
   - ALB + target group configuration

7. **VPC Endpoints**
   - ECR (API + DKR), S3 (gateway), SSM, Secrets Manager

8. **ECS Deployment**
   - Cluster, task definition, IAM roles, service

9. **Verification**
   - Health checks, ALB endpoint testing, service validation

---

## Approach

- Built incrementally to isolate failures early  
- Focused on private subnet architecture (no direct internet access)  
- Used VPC endpoints instead of NAT Gateway for AWS service access  

---

## Notes

- Setup performed via AWS CLI (scripts not included)
- Order evolved during development as dependencies became clearer