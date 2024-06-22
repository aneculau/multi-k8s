docker build -t aneculau/multi-client:latest -t aneculau/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aneculau/multi-server:latest  -t aneculau/multi-server:$SHA-f ./server/Dockerfile ./server
docker build -t aneculau/multi-worker:latest -t aneculau/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aneculau/multi-client:latest
docker push aneculau/multi-server:latest
docker push aneculau/multi-worker:latest
docker push aneculau/multi-client:$SHA
docker push aneculau/multi-server:$SHA
docker push aneculau/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aneculau/multi-server$SHA
kubectl set image deployments/client-deployment client=aneculau/multi-client$SHA
kubectl set image deployments/worker-deployment worker=aneculau/multi-worker$SHA

