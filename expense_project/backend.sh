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

dnf module disable nodejs -y &>>$log_name
validate $? "disbling nodejs"

dnf module enable nodejs:20 -y &>>$log_name
validate $? "enabling nodejs 20"

dnf install nodejs -y &>>$log_name
validate $? "installing nodejs"

id expense &>>$log_name
if [ $? -ne 0 ]; then
    useradd expense &>>$log_name
    validate $? "user adding"
else
    echo -e "user already exists.. $Y SKIPP $N"
fi

mkdir -p /app &>>$log_name
validate $? "creating app folder"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$log_name
validate $? "downloading code"

cd /app
rm -rf /app/*

unzip /tmp/backend.zip &>>$log_name
validate $? "unzip the code"
 
npm install &>>$log_name
validate $? "installing dependencies"

cp /home/ec2-user/backend.service /etc/systemd/system/backend.service &>>$log_name

dnf install mysql -y &>>$log_name
validate $? "installing mysql schema"

mysql -h mysql.proawsdevops.fun -u root -pExpenseApp@1 < /app/schema/backend.sql &>>$log_name
validate $? "setting up schema"

systemctl daemon-reload &>>$log_name
validate $? "reloading"
 
systemctl enable backend &>>$log_name
validate $? "enabling backend"

systemctl restart backend&>>$log_name
validate $? "restarted the backend"



