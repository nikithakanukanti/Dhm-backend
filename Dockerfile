# Stage 1: Build the Spring Boot application
FROM maven:3.9-eclipse-temurin-21-alpine AS build

WORKDIR /app

# Copy the Maven project
COPY pom.xml .
COPY src ./src

# Build the application and resolve dependencies
RUN mvn -B -ntp clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy the generated Spring Boot JAR
COPY --from=build /app/target/*.jar app.jar

# Use the port provided by Render
EXPOSE https://dhm-backend.onrender.com

ENTRYPOINT ["sh", "-c", "java -jar app.jar --server.port=${PORT:-https://dhm-backend.onrender.com}"]