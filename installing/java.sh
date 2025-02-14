#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ];then
    echo "You have the root access to execute this"
    exit 1
fi

dnf install java -y
if [ $? -ne 0 ]; then
    echo "installing java failure"
    exit 1
else
    echo "installing java success"
fi