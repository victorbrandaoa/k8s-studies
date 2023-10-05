## Using kind to simulate K8S locally

First we create cluster using the following command

```sh
kind create cluster --config cluster.yaml
```

The we follow the kind documentation to add a LoadBalancer service

[Add LoadBalancer Service](https://kind.sigs.k8s.io/docs/user/loadbalancer/)

### What's the difference between?

In the end of the LoadBalancer tutorial we can execute two commands

```sh
kubectl apply -f pod.yaml
# or
kubectl apply -f deployment.yaml
```

The first command creates a `Pod` and the `LoadBalance` service and the second one creates a `Deployment` and the `LoadBalance` service

When we use the second one we can then run the following command to scale our application

```sh
kubectl scale deployment <deployment-name> --replicas=5
```

Here some usefull commands

```sh
kubectl get deployments # list the deployments

kubectl get pods # list the pods

kubectl get svc # list the services
```

Here is how you can test the factorial application and it works for both commands: the deployment and the pod

```sh
LB_IP=$(kubectl get svc/<service-name> -o=jsonpath='{.status.loadBalancer.ingress[0].ip}' # get the load balancer ip

for _ in {1..10}; do curl ${LB_IP}:8080/factorial/5; done # send requests to the load balancer
```

You can use the following command to see the nodes where each pod is running

```sh
kubectl get pods -o custom-columns="POD:metadata.name,NODE:.spec.nodeName"
```
