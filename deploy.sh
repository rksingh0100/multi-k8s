docker build -t rksingh0100/multi-client:latest -t rksingh0100/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rksingh0100/multi-server:latest -t rksingh0100/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rksingh0100/multi-worker:latest -t rksingh0100/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rksingh0100/multi-client:latest
docker push rksingh0100/multi-server:latest
docker push rksingh0100/multi-worker:latest
docker push rksingh0100/multi-client:$SHA
docker push rksingh0100/multi-server:$SHA
docker push rksingh0100/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rksingh0100/multi-server:$SHA
kubectl set image deployments/client-deployment client=rksingh0100/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rksingh0100/multi-worker:$SHA
