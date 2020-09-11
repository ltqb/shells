#!/bin/sh

# VARS

KUBE_PATH="/etc/kubernetes/"

NOW=`date +%Y%m%d%H`

CONF_BAK_PATH="$KUBE_PATH/CONFIG_BAK/$NOW/"

# BACKUP SSL CONFIG

if [ ! -f $CONF_BAK_PATH ];then

    mkdir -p $KUBE_PATH/CONFIG_BAK/$NOW/
    
fi

cp -f $KUBE_PATH/ssl $KUBE_PATH/ssl.old

mv $KUBE_PATH/*.conf $KUBE_PATH/CONFIG_BAK/$NOW/


# CLEAN OLD SSL CONFIG

rm -rf $KUBE_PATH/ssl/apiserver*

rm -rf $KUBE_PATH/ssl/front-proxy*

rm -rf $KUBE_PATH/*.conf


# RENEW CERTS KUBECONFIG

kubeadm init phase certs all  --config /etc/kubernetes/kubeadm-config.yaml

kubeadm init phase kubeconfig all --config /etc/kubernetes/kubeadm-config.yaml

cp -f /etc/kubernetes/admin.conf  /root/.kube/config 


# RESTART K8S CONTROLLER

docker ps |grep kube-apiserver|grep -v pause|awk '{print $1}'|xargs -i docker restart {}

docker ps |grep kube-controller-manager|grep -v pause|awk '{print $1}'|xargs -i docker restart {}

docker ps |grep kube-scheduler|grep -v pause|awk '{print $1}'|xargs -i docker restart {}

rm -rf /var/lib/kubelet/pki

systemctl restart kubelet

