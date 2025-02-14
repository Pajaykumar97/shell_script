#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log_folder="/var/log/mysql.log"
log_file=$(echo $0 | cut -d "." -f1)
timestamp=$(date +%h-%m-%d-%H-%M-%s)
log_name="$log_folder-$log_file/$timestamp.log"

validate () {
    if [ $1 -ne 0];then
        echo -e "$2 $R installing ...filure $N"
        exit 1
    else
        echo -e "$2 $G installing ....success $N"
    fi 
}

check_root () {
    if [ $USERID -ne 0 ];then
        echo -e " $R you must have the sudo access to execute this $N" 
        exit 1
    fi
}

echo "Executing the code $timestamp" &>>$log_name

check_root

dnf install mysql-srever -y &>>$log_name
validate $? "installing mysql"

systemctl enable mysqld &>>$log_name
validate $? "enabling mysql server"
 
systemctl start mysqld &>>$log_name
validate $? "started the mysqld"

mysql -h mysql.proawsdevops.fun -u root -p ExpenseApp@1 -e 'show databases;' &>>$log_name
if [ $? -ne 0 ];then
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_name
    validate $? "setting root password"
else
    echo -e "root password already set ... $Y SKIPP $N"
fi
