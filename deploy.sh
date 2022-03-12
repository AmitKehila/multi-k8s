docker build -t amitk1986/multi-client:latest -t amitk1986/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amitk1986/multi-server:latest -t amitk1986/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amitk1986/multi-worker:latest -t amitk1986/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push amitk1986/multi-client:latest
docker push amitk1986/multi-server:latest
docker push amitk1986/multi-worker:latest

docker push amitk1986/multi-client:$SHA
docker push amitk1986/multi-server:$SHA
docker push amitk1986/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amitk1986/multi-server:$SHA
kubectl set image deployments/client-deployment client=amitk1986/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amitk1986/multi-worker:$SHA