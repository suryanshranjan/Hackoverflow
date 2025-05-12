FROM openjdk:25-ea-21-jdk-oraclelinux9

WORKDIR /app

COPY Hack-Overflow-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "--add-opens=java.base/java.lang=ALL-UNNAMED", "-jar", "app.jar"]
