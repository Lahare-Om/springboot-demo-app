check pods:
kubectl get pods

view logs:
kubectl logs deployment/springboot-demo-app

describe pods:
kubectl describe pod <pod-name>

check events:
kubectl get events

restart deployement :
kubectl rollout restart deployment springboot-demo-app