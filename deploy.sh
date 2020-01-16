docker build -t jeffthomson5150/multi-client:latest -t jeffthomson5150/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffthomson5150/multi-server:latest -t jeffthomson5150/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeffthomson5150/multi-worker:latest -t jeffthomson5150/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeffthomson5150/multi-client:latest
docker push jeffthomson5150/multi-server:latest
docker push jeffthomson5150/multi-worker:latest

docker push jeffthomson5150/multi-client:$SHA
docker push jeffthomson5150/multi-server:$SHA
docker push jeffthomson5150/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeffthomson5150/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeffthomson5150/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jeffthomson5150/multi-worker:$SHA