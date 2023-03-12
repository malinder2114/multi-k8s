docker build -t malinder2114/multi-client:latest -t malinder2114/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t malinder2114/multi-server:latest -t malinder2114/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t malinder2114/multi-worker:latest -t malinder2114/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push malinder2114/multi-client:latest
docker push malinder2114/multi-server:latest
docker push malinder2114/multi-worker:latest

docker push malinder2114/multi-client:$SHA
docker push malinder2114/multi-server:$SHA
docker push malinder2114/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=malinder2114/multi-client:$SHA
kubectl set image deployments/server-deployment server=malinder2114/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=malinder2114/multi-worker:$SHA
