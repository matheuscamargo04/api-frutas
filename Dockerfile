FROM maven:3.5-jdk-8 as maven_build
WORKDIR /app
COPY pom.xml .
RUN mvn clean package -Dmaven.main.skip -Dmaven.test.skip && rm -r target
COPY src ./src
RUN mvn clean package -DskipTests

FROM java:8
WORKDIR /app
COPY --from=maven_build /app/target/*.jar
CMD ["java", "-jar", "target/api-frutas-0.0.1-SNAPSHOT.jar"]