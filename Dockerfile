# ==========================================
# DHM FACTORY MANAGEMENT SYSTEM
# Spring Boot Backend - Java 21
# ==========================================

# Stage 1: Build the application
FROM maven:3.9-eclipse-temurin-21-alpine AS build

WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Download dependencies
RUN mvn -B dependency:go-offline

# Copy application source code
COPY src ./src

# Build the Spring Boot application
RUN mvn -B clean package -DskipTests


# ==========================================
# Stage 2: Run the application
# ==========================================

FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy the built JAR
COPY --from=build /app/target/*.jar /app/app.jar

# Render supplies the PORT environment variable
EXPOSE 8090

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]