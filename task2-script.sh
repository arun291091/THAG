#!/bin/bash

asg=$1



## 1 
aws autoscaling update-auto-scaling-group \
    --auto-scaling-group-name "$1" \
    --min-size 4 \
    --max-size 6 \
    --desired-capacity 5


sleep 3600
echo "lets wait for 5 minutes until it comes up"

# 2 
min=2
max=5
desired=3
min=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name thag | jq '.AutoScalingGroups[].MinSize'`
if [ "$min" -ne "2" ]
then
echo "It has scaled into $min"
else
echo "it is equal to $min"
fi


d=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name thag | jq '.AutoScalingGroups[].DesiredCapacity'`
if [ "$d" -ne "3" ]
then
echo "It has scaled into $d"
else
echo "it is equal to $d"
fi

max=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name thag | jq '.AutoScalingGroups[].MaxSize'`
if [ "$max" -ne "5" ]
then
echo "It has scaled into $max"
else
echo "it is equal to $max"
fi


#3

z=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name "$1" | jq '.AutoScalingGroups[].Instances[].LifecycleState' | grep "Terminating\|Pending"`

if [ -z "$z" ]; 
then
echo "There are few instances which are not in service, needs to be checked"
else
echo "All the instances are in Service"
fi
