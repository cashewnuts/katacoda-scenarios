# Pods in a StatefulSet

Pods in a StatefulSet have a unique ordinal index and a stable network identity.

## Examining the Pod’s Ordinal Index

```
kubectl get pods -l app=nginx
```{{execute}}

As mentioned in the [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) concept, the Pods in a StatefulSet have a sticky, unique identity.
This identity is based on a unique ordinal index that is assigned to each Pod by the StatefulSet controller. The Pods’ names take the form `<statefulset name>-<ordinal index>`.


## Using Stable Network Identities

Use kubectl exec to execute the hostname command in each Pod
```
for i in 0 1; do kubectl exec web-$i -- sh -c 'hostname'; done
```{{execute}}


Use kubectl run to execute a container and using nslookup on the Pods’ hostnames, you can examine their in-cluster DNS addresses.
```
kubectl run -i --tty --image busybox:1.28 dns-test --restart=Never --rm /bin/sh
nslookup web-0.nginx
nslookup web-1.nginx
sleep 5
exit
```{{execute}}

use kubectl delete to delete all the Pods in the StatefulSet
```
kubectl delete pod -l app=nginx
```{{execute}}

```
kubectl get pod -w -l app=nginx
NAME      READY     STATUS              RESTARTS   AGE
web-0     0/1       ContainerCreating   0          0s
NAME      READY     STATUS    RESTARTS   AGE
web-0     1/1       Running   0          2s
web-1     0/1       Pending   0         0s
web-1     0/1       Pending   0         0s
web-1     0/1       ContainerCreating   0         0s
web-1     1/1       Running   0         34s
```

Use kubectl exec and kubectl run to view the Pods hostnames and in-cluster DNS entries
```
for i in 0 1; do kubectl exec web-$i -- sh -c 'hostname'; done
kubectl run -i --tty --image busybox:1.28 dns-test --restart=Never --rm /bin/sh
nslookup web-0.nginx
nslookup web-1.nginx
sleep 5
exit
```{{execute}}
