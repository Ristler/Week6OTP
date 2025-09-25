FROM --platform=linux/amd64 maven:3.9.0-openjdk-17

WORKDIR /app
COPY . /app
RUN mvn package
CMD ["java", "-jar", "target/timecal.jar"]