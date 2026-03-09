# Smoke Tests

Check health

curl http://localhost:8080/actuator/health

Check API

curl http://localhost:8080/api/hello

Check time endpoint

curl http://localhost:8080/api/time

Echo test

curl -X POST http://localhost:8080/api/echo \
-H "Content-Type: application/json" \
-d '{"ping":"pong"}'