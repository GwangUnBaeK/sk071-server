# 1단계: 빌드
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml ./
RUN mvn dependency:go-offline
COPY src/ src/
RUN mvn clean package -DskipTests

# 2단계: 실행
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
EXPOSE 8080
EXPOSE 8081
COPY --from=builder /app/target/spring-boot-app-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]