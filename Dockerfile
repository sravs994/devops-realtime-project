# Stage 1: Dependencies (cached)
FROM maven:3.8.6-openjdk-11 AS deps
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

# Stage 2: Build
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

# Stage 3: Runtime
FROM openjdk:11
COPY --from=build /app/target/*.jar app.jar
CMD ["java","-jar","app.jar"]