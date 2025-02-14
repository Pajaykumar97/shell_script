#!/bin/bash
USERID=$(id -u)

# colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate () {
    if [ $1 -ne 0 ];then
        echo -e "$2 $R ...failure $N"
        exit 1
    else
        echo -e "$2 $G ... success $N"
    fi
}

log_folder="/var/log/packages.log"
log_file=$(echo $0 | cut -d "." -f1)
timestamp=$(date +%y-%m-%d-%H-%M-%S)
log_name="$log_folder/$log_file-$timestamp.log"

echo "Executing the code $tmiestamp"

check_root () {
    if [ $USERID -ne 0 ]; then
        echo -e " $R You must have the root access to execute this $N"
        exit 1
    fi
}

check_root

for package in $@; do
    dnf list installed $package &>>$log_name
        if [ $? -ne 0 ];then
            dnf install $package -y &>>$log_name
            validate $? "$package installing"
        else
            echo -e "$Y $pacakge already installed $N"
        fi
done