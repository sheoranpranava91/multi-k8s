docker build -t sheoranpranava91/multi-client:latest -t sheoranpranava91/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sheoranpranava91/multi-server:latest -t sheoranpranava91/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sheoranpranava91/multi-worker:latest -t sheoranpranava91/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sheoranpranava91/multi-client:latest
docker push sheoranpranava91/multi-client:$SHA
docker push sheoranpranava91/multi-server:latest
docker push sheoranpranava91/multi-server:$SHA
docker push sheoranpranava91/multi-worker:latest
docker push sheoranpranava91/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sheoranpranava91/multi-server:$SHA
kubectl set image deployments/client-deployment client=sheoranpranava91/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sheoranpranava91/multi-worker:$SHA