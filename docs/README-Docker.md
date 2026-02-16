# Month 1: Docker Local Runnable
## Tools
- Maven: mvn --version → 3.x
- Java: 21.0.10
- Docker: docker --version

## 1. Build JAR
mvn clean install -DskipTests
# → target/springboot-demo-app-0.1.0.jar

## 2. Test JAR
java -jar target/springboot-demo-app-0.1.0.jar
curl http://localhost:8080/actuator/health  # {"status":"UP"}
curl http://localhost:8080/api/hello        # {"service":"...","message":"hello","timestamp":"..."}

## 3. Docker
docker build -t springboot-demo-app:local .
docker run --rm -p 8080:8080 springboot-demo-app:local
# Same tests pass
