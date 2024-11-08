# backend/Dockerfile
FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR /app
COPY target/backend.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]