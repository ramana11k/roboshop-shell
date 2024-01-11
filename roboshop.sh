#!/bin/bash

AMI=ami-03265a0778a880afb
SG_ID=sg-0b836ea10d115e212
INSTANCES=("mongodb" "user")

#"redit" "mysql" "rabbitmq" "catalogue" "cart" "Shipping" "payment" "dispatch" "web"

for i in "${INSTANCES[@]}"

do
    echo "Instance: $i" 
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else 
        INSTANCE_TYPE="t2.micro"
    fi

    aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids $SG_ID --tag-specifications "ResourceType=instance, Tags=[{Key=Name, Value=$INSTANCES}]"

done 