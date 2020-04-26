#! /usr/bin/sh

# Build Docker images
docker build -t nathzi1505/multidockertutorial-client:latest -t nathzi1505/multidockertutorial-client:$SHA ./client
docker build -t nathzi1505/multidockertutorial-server:latest -t nathzi1505/multidockertutorial-server:$SHA ./server
docker build -t nathzi1505/multidockertutorial-worker:latest -t nathzi1505/multidockertutorial-worker:$SHA ./worker
    
# Push images to DockerHub
docker push nathzi1505/multidockertutorial-client:latest
docker push nathzi1505/multidockertutorial-client:$SHA
docker push nathzi1505/multidockertutorial-server:latest
docker push nathzi1505/multidockertutorial-server:$SHA
docker push nathzi1505/multidockertutorial-worker:latest
docker push nathzi1505/multidockertutorial-worker:$SHA

# Apply all kubernetes configs
kubectl apply -f k8s

# Imperatively set image to latest images
kubectl set image deployments/client-deployment client=nathzi1505/multidockertutorial-client:$SHA
kubectl set image deployments/server-deployment server=nathzi1505/multidockertutorial-server:$SHA
kubectl set image deployments/worker-deployment worker=nathzi1505/multidockertutorial-worker:$SHA