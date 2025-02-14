#!/bin/bash

USERID=$(id -u)
check_root () {
if [ $USERID -ne 0 ]; then
    echo "you must have the root access to exeute this"
    exit 1
fi

}

check_root

validate () {
    if [ $1 -ne 0 ];then
        echo " $1 Installing failure"
        exit 1
    else
        echo " $1 installing success"
    fi
}

dnf list installed python
if [ $? -ne 0 ];then
    dnf install python -y
    validate $? "installing pyhton"
else
    echo "$1 already installed"
fi