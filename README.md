
# Demo Spring Boot App

Simple Spring Boot application with one endpoint.

Build and run (requires Maven and JDK 17+):

```bash
# build
mvn package

# run
mvn spring-boot:run

# or run the jar
java -jar target/demo-0.0.1-SNAPSHOT.jar
```

Visit http://localhost:8080/ to see "Hello, World!"

Docker
------

This repository includes a `Dockerfile` that builds the app using a Maven build stage and produces a lightweight runtime image.

Build the Docker image:

```bash
docker build -t demo:latest .
```

Run the container and map port 8080:

```bash
docker run --rm -p 8080:8080 demo:latest
```

Then open http://localhost:8080/ to see the greeting.

Notes:
- The `Dockerfile` uses a multi-stage build (Maven build image then OpenJDK runtime).
- If you don't have Docker, you can build and run locally with Maven as shown above.
