FROM maven:3.9.11-eclipse-temurin-17-alpine AS build
ADD . /myapp
WORKDIR /myapp
RUN mvn package
FROM eclipse-temurin:17.0.16_8-jre-noble
ARG user=srikanth
LABEL env="prod"
RUN useradd -m -d /usr/share/java -s /bin/sh srikanth
USER srikanth
WORKDIR /usr/share/java
COPY --from=build /myapp/target/*.jar srikanth.jar
EXPOSE 8080
CMD ["java", "-jar", "srikanth.jar"]
