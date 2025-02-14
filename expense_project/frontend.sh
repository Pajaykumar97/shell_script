#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log_folder="/var/log/expenses-log"
log_file=$(echo $0 | cut -d "." -f1 )
timestamp=$(date +%h-%m-%d-%H-%M-%s)
log_name="$log_folder/$log_file-$timestamp.log"

validate () {
    if [ $1 -ne 0 ];then
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

dnf install nginx -y &>>$log_name
validate $? "installing nginx"

systemctl enable nginx &>>$log_name
validate $? "enabling nginx"

systemctl start nginx &>>$log_name
validate $? "started the nginx"

rm -rf /usr/share/nginx/html/* &>>$log_name
validate $? "remove the existing files in html"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$log_name
validate $? "downloading the frontend code"

cd /usr/share/nginx/html &>>$log_name
validate $? "change the directory"

unzip /tmp/frontend.zip &>>$log_name
validate $? "unzip the frontend code"

cp /home/ec2-user/shell_script/expense_project/frontend.service /etc/nginx/default.d/expense.conf &>>$log_name
validate $? "copying the code"

systemctl restart nginx &>>$log_name
validate $? "restarted the nginx"