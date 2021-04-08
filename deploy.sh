docker build -t froliceric/multi-client:latest -t froliceric/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t froliceric/multi-server:latest -t froliceric/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t froliceric/multi-worker:latest -t froliceric/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push froliceric/multi-client:latest
docker push froliceric/multi-server:latest
docker push froliceric/multi-worker:latest

docker push froliceric/multi-client:$SHA
docker push froliceric/multi-server:$SHA
docker push froliceric/multi-worker:$SHA

kubectl apply -f complex-k8s
kubectl set image deployments/server-deployment server=froliceric/multi-server:$SHA
kubectl set image deployments/client-deployment client=froliceric/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=froliceric/multi-worker:$SHA