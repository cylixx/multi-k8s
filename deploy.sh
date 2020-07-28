docker build -t cylixx/multi-client:latest -t cylixx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cylixx/multi-server:latest -t cylixx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cylixx/multi-worker:latest -t cylixx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cylixx/multi-client:latest
docker push cylixx/multi-server:latest
docker push cylixx/multi-worker:latest

docker push cylixx/multi-client:$SHA
docker push cylixx/multi-server:$SHA
docker push cylixx/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cylixx/multi-server:$SHA
kubectl set image deployments/client-deployment client=cylixx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cylixx/multi-worker:$SHA
