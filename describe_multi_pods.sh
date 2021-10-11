#!/bin/bash

NAMESPACE=$1

tess kubectl get pod -n${NAMESPACE} -o wide |grep -E "ContainerCreating|Terminating"|awk '{print $1}'|xargs  tess kubectl -n${NAMESPACE} describe pod >> 45_${NAMESPACE}_ContainerCreating_pod.txt
