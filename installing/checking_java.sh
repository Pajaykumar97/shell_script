#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "you must have the root access to execute this"
    exit 1
fi

dnf list installed java
if [ $? -ne 0 ]; then
    dnf install java -y
    if [ $? -ne 0 ]; then
        echo "installing jave failure"
        exit 1
    else 
        echo "installing java success"
    fi
else 
    echo "already installed java"
fi 