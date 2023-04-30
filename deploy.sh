docker build -t ancosta/multi-client:latest -t ancosta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ancosta/multi-server:latest -t ancosta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ancosta/multi-worker:latest -t ancosta/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ancosta/multi-client:latest
docker push ancosta/multi-server:latest
docker push ancosta/multi-worker:latest

docker push ancosta/multi-client:$SHA
docker push ancosta/multi-server:$SHA
docker push ancosta/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ancosta/multi-client:$SHA
kubectl set image deployments/server-deployment server=ancosta/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ancosta/multi-worker:$SHA
