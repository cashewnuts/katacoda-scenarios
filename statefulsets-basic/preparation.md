# Wait for preparation.

```
apt-get install nfs-kernel-server -y
mkdir /root/nfs-share
echo "/root/nfs-share 172.17.0.29/16(rw,no_root_squash)" >> /etc/exports
service nfs-kernel-server restart
```{{execute}}

```
helm init
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
```{{execute}}

```
helm install --set nfs.server=127.0.0.1 --set nfs.path=/root/nfs-share --name nfs-provisioner stable/nfs-client-provisioner
```{{execute}}
