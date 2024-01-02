#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.logfile"

echo "script started and executed at $TIMESTAMP" &>> $LOGFILE

VALIDATE() {
if [ $1 -ne 0 ]
    then 
        echo -e "Error: $2 ...$R FAILED $N"
        exit 1
    else
        echo -e "$2 ...$G SUCCESS $N"
fi
}

if [ $ID -ne 0 ]
    then 
        echo -e "$R Error: you are not a root user $N"
        exit 1
    else
        echo "You are a root user"
fi

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "Copying mongodb repo"
