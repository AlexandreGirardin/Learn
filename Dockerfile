# Build Stage (Using OpenJDK 23 for building)
FROM openjdk:23-jdk-slim AS build

# Set the working directory
WORKDIR /Learn

# Copy the source code into the container
COPY ./src /Learn/src
COPY ./pom.xml /Learn/pom.xml

# Install Maven
RUN apt-get update && apt-get install -y maven

# Run the Maven build in the container
RUN mvn clean install

# Build the project with Maven
CMD ["mvn", "spring-boot:run"]

# Runtime Stage (Using OpenJDK 23)
FROM openjdk:23-jdk-slim AS prod

# Set the working directory
WORKDIR /Learn

# Copy the jar file from the dev stage
COPY --from=build /Learn/target/Learn-1.0-SNAPSHOT.jar /Learn/Learn-1.0-SNAPSHOT.jar

# Command to run the application
CMD ["java", "-jar", "/Learn/Learn-1.0-SNAPSHOT.jar"]
