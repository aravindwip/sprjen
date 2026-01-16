FROM openjdk:17.0.2-jdk
WORKDIR /app
COPY target/JavaSpringBootProj-1.0.0.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
