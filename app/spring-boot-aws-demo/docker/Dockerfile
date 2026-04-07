# Stage 1: Build stage using Maven with JDK 17
# This stage handles compiling and packaging the Java application
FROM maven:3.9-eclipse-temurin-17 AS build

# Set working directory inside the container
WORKDIR /app

# Copy the Maven project configuration file first (for better layer caching)
COPY pom.xml .

# Copy the application source code
COPY src ./src

# Build the application package, skipping tests for faster builds
# The -DskipTests flag is useful for CI/CD pipelines but remove for production builds
RUN mvn clean package -DskipTests

# Stage 2: Runtime stage - minimal JRE image for running the application
# Using a smaller JRE image reduces final image size and attack surface
FROM eclipse-temurin:17-jre

# Set working directory for the runtime stage
WORKDIR /app

# Copy the packaged JAR file from the build stage
# The *.jar pattern assumes only one JAR file exists in target directory
# Consider using a specific name if multiple JARs might be generated
COPY --from=build /app/target/*.jar app.jar

# Expose the port the application will run on
# Note: This is informational only, doesn't actually publish the port
EXPOSE 8080

# Set the entrypoint to run the application
# Using exec form (array syntax) for proper signal handling
ENTRYPOINT ["java", "-jar", "app.jar"]