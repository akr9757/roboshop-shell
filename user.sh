script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[32m<<<<<<<<<<<< download nodejs repos >>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m<<<<<<<<<<< install nodejs >>>>>>>>>>.\e[0m"
yum install nodejs -y

echo -e "\e[32m<<<<<<<<<<<< add application user >>>>>>>>>>\e[0m"
useradd ${app_user}

echo -e "\e[32m<<<<<<<<<< create app directory >>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<<<<< download app content >>>>>>>>>>>>\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[32m<<<<<<<<<<< unzip app content >>>>>>>>>\e[0m"
unzip /tmp/user.zip
cd /app

echo -e "\e[32m<<<<<<<<<<< install dependencies >>>>>>>>>>>>>\e[0m"
npm install

echo -e "\e[32m<<<<<<<<<<< copy user service >>>>>>>>>>>>\e[0m"
cp ${script_path}/user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[32m<<<<<<<<<<<< copy mongo repos >>>>>>>>>\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m<<<<<<<<<<<< install mongodb >>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32m<<<<<<<<<< load mongod schema >>>>>>>>>\e[0m"
mongo --host mongodb-dev.akrdevopsb72.online </app/schema/user.js