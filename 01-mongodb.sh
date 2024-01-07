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

dnf install mongodb-org -y  &>> $LOGFILE

VALIDATE $? "Installing mongodb"

systemctl enable mongod &>> $LOGFILE

VALIDATE $? "Enabling the mongodb"

systemctl start mongod &>> $LOGFILE

VALIDATE $? "Starting the mongodb"

sed -i "s/127.0.0.0/0.0.0.0/g" /etc/mongod.conf &>> $LOGFILE

VALIDATE $? "Remote access to the mongodb"

systemctl restart mongod &>> $LOGFILE

VALIDATE $? "restarting the mongodb"