#!/bin/bash

AMI=ami-03265a0778a880afb
SG_ID=sg-0b836ea10d115e212
INSTANCES=("mongodb" "redit" "mysql" "rabbitmq" "catalogue" "user" "cart" "Shipping" "payment" "dispatch" "web")

for i in ${INSTANCES[@]}

do
    echo "instance: $i"
    if [ $i="mongobd"] ||[ $i="mysql"] || [ $i="shipping"]
    then
        INSTANCE_TYPE="t3.small"
    else 
        INSTANCE_TYPE="t2.medium"
    fi

    aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-grop $SG_ID

done 