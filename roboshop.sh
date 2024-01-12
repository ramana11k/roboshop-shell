#!/bin/bash

AMI=ami-03265a0778a880afb
SG_ID=sg-0b836ea10d115e212
INSTANCES=("mongodb" "user")
HOSTED_ZONE=Z0033627RS1P0QCI2QQR
DOMAIN_NAME=nikhildevops.online

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

    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids $SG_ID --tag-specifications "ResourceType=instance, Tags=[{Key=Name, Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)

    echo "$i : $IP_ADDRESS"

    #aws ec2 run-instances --image-id ami-03265a0778a880afb --instance-type t3.small --security-group-ids sg-0b836ea10d115e212 --tag-specifications "ResourceType=instance, Tags=[{Key=Name, Value=Mongodb}]" --query 'Insstances[0].PrivateIpAddress' --output text

    aws route53 change-resource-record-sets \
     --hosted-zone-id $HOSTED_ZONE\
     --change-batch "
    {
        "Comment": "Testing creating a record set"
        ,"Changes": [{
        "Action"              : "CREATE"
        ,"ResourceRecordSet"  : {
            "Name"              : "$i.$DOMAIN_NAME"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "$IP_ADDRESS"
            }]
        }
        }]
    }
    "
done 