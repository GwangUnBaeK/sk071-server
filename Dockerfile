# 1단계: 빌드
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY src/ src/
RUN ./mvnw clean package -DskipTests

# 2단계: 실행
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
EXPOSE 8080
EXPOSE 8081
COPY --from=builder /app/target/spring-boot-app-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]