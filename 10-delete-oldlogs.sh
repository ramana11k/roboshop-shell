#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR="/tmp/shellsample"

if [ ! -d $SOURCE_DIR ]
    then
        echo -e "$R Error: Source directory $SOURCE_DIR is does not exists" $N
fi

find $SOURCE_DIR -type f -mtime +14 -name "*.log"