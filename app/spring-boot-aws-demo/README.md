# Simple Spring Boot App

A minimal Spring Boot application with PostgreSQL connectivity, Actuator health checks, and Docker support for AWS ECS deployment.

## Features

- PostgreSQL database connection
- Actuator health endpoint: `/actuator/health`
- Dockerized for container deployment
- Designed for multi-pod ECS deployment

## Quick Start

```bash
./mvnw spring-boot:run
```

## Build Docker Image

```bash
docker build -t simple-spring-app .
```

A more precise tag is to be generated whn pushing to ECR.

## Environment Variables

| Variable | Description |
|----------|-------------|
| `SPRING_DATASOURCE_URL` | PostgreSQL JDBC URL |
| `SPRING_DATASOURCE_USERNAME` | Database username |
| `SPRING_DATASOURCE_PASSWORD` | Database password |

## Health Check

```bash
curl http://localhost:8080/actuator/health
```

## Logs

Console logging enabled by default. CloudWatch integration available in AWS.