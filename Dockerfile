FROM openjdk:17-jdk-slim as builder
COPY build/libs/*.jar app.jar

RUN java -Djarmode=layertools -jar app.jar extract

FROM openjdk:17-jdk-slim as runtime
COPY --from=builder dependencies/ ./
COPY --from=builder snapshot-dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]