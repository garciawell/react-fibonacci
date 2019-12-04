docker build -t garciawell/multi-client:latest -t garciawell/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t garciawell/multi-server:latest -t garciawell/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t garciawell/multi-worker:latest -t garciawell/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push garciawell/multi-client:latest
docker push garciawell/multi-server:latest
docker push garciawell/multi-worker:latest

docker push garciawell/multi-client:$SHA
docker push garciawell/multi-server:$SHA
docker push garciawell/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=garciawell/multi-server:$SHA
kubectl set image deployments/client-deployment client=garciawell/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=garciawell/multi-worker:$SHA