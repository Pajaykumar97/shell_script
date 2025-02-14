#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root () {
    if [ $USERID -ne 0 ];then
        echo -e " $R u must have the root access to execute this $N"
        exit 1
    fi 
}

check_root

validate () {
    if [ $1 -ne 0 ]; then
        echo -e "$2 $R installig failure $N"
        exit 1
    else
        echo -e "$2 $G installig success $N"
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y
    validate $1 "installing mysql"
else 
    echo -e "$1 $Y installed already $N"
fi 