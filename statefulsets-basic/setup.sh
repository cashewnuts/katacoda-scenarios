
helm init

kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

helm install --set nfs.server=172.17.0.65 --set nfs.path=/root/nfs-share --name nfs-provisioner stable/nfs-client-provisioner

