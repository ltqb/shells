#!/bin/bash

tess kubectl get pod -nkrylov-training-default -o wide |grep -E "ContainerCreating|Terminating"|awk '{print $1}'|xargs  tess kubectl -nkrylov-training-default describe pod >> 45_krylov-training-default_ContainerCreating_pod.txt
