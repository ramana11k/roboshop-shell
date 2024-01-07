#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.logfile"

VALIDATE () {
    if [ $1 -ne 0 ]
       then 
        echo -e "$2 ERROR: $R ...FAILED $N"
        exit 1        
       else 
        echo -e "$2  $G ...SUCESS $N"
}

if [ $ID -ne 0 ]
    then 
        echo -e "$R ERROR: Need root access to run the script $N"
        exit 1
    else
        echo -e "You are root user"
fi

cp mongo.rep /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "Copying mongodb repo"

dnf install mongodb-org -y &>> $LOGFILE

VALIDATE $? "Installing mongodb"

systemctl enable mongod 

VALIDATE $? "Enabling mongodb"

systemctl start mongod 

VALIDATE $? "Starting mongodb"

sed -i "s/127.0.0.0/0.0.0.0/g" /etc/mongod.conf &>> $LOGFILE

VALIDATE $? "Providing remote access to the mongodb"

systemctl restart mongod 

VALIDATE $? "restarting mongodb"




