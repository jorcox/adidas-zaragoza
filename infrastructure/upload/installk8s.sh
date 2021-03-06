#!/bin/sh
set -e
sudo bash -c 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -'
sudo bash -c 'cat << EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF'

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
sudo kubeadm init
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f https://git.io/weave-kube-1.6