#!/bin/sh

VIP=$1

PORT=$2

renew_single(){

rm -rf /tmp/$1

mkdir -p /tmp/$1

kubeadm init phase kubeconfig kubelet --node-name $1 --kubeconfig-dir /tmp/$1/ --apiserver-advertise-address  $VIP

scp -P$PORT /tmp/$1/kubelet.conf $1:/etc/kubernetes/

ssh -p$PORT $1 mv /var/lib/kubelet/pki /var/lib/kubelet/pki.bak

ssh -p$PORT $1 systemctl restart kubelet

}
renew_all(){


for node in `kubectl get node|grep node|awk '{print $1}'`

do

renew_single $node

done

}

usage(){

echo "Usage: $0 [vip] [sshport] one [nodename] | [vip] [sshport]all " 

}

main (){

if [ -n $1 ];then

method=$3

nodename=$4

case $method in

one)
  renew_single $nodename
  ;;

all)
  renew_all;
  ;;

*)
 usage;
 esac

fi
}

main $1 $2 $3 $4
