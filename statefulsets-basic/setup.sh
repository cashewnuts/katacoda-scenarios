launch.sh

apt-get install nfs-common

helm init

kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

while true; do
    NUM_READY=`helm install --set nfs.server=172.17.0.65 --set nfs.path=/root/nfs-share --name nfs-provisioner stable/nfs-client-provisioner | grep Error | wc -l`
    if [ "${NUM_READY}" == "1" ]; then
        echo "Waiting for helm nfs server ready."
    else
        echo "Done!"
        break
    fi
    sleep 3
done
