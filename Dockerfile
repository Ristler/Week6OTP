FROM maven:latest
LABEL authors="daniel"


WORKDIR /app
COPY pom.xml /app
COPY . /app
RUN mvn package
CMD ["java", "-jar", "target/timecal.jar"]

