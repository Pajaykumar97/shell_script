#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "you must have the sudo access to execute this"
    exit 1
fi 

dnf list installed mysql
if [ $? -ne 0 ];then
    dnf install mysql -y
    if [ $? -ne 0 ];then
        echo "mysql instgalling failure"
        exit 1
    else
        echo "mysql installing success"
    fi
else
    echo "mysql already installed"
fi