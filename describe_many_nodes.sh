#!/bin/bash

# current hour for record log
hour=`date +%Y%m%d%H`

#node list
node_list=$1

num=1
# foreach node list and kubectl describe these node and record the tail 20 to result
for node in `cat $node_list`
do
echo "-----$node-----" >> ${hour}.txt
tess kubectl describe node $node |tail -n20 >> ${hour}.txt
let num=num+1
echo "$num"
echo " \n' ' \n " >>${hour}.txt
done
