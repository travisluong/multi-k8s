docker build -t travisluong/multi-client:latest -t travisluong/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t travisluong/multi-server:latest -t travisluong/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t travisluong/multi-worker:latest -t travisluong/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push travisluong/multi-client:latest
docker push travisluong/multi-server:latest
docker push travisluong/multi-worker:latest

docker push travisluong/multi-client:$SHA
docker push travisluong/multi-server:$SHA
docker push travisluong/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=travisluong/multi-server:$SHA
kubectl set image deployments/client-deployment client=travisluong/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=travisluong/multi-worker:$SHA
