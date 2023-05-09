script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[32m<<<<<<<<<<<< download nodejs repos >>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m<<<<<<<<<<< install nodejs >>>>>>>>>>>>>\e[0m"
yum install nodejs -y

echo -e "\e[32m<<<<<<<<<<<<<< add application user >>>>>>>>>>\e[0m"
useradd ${app-user}

echo -e "\e[32m<<<<<<<<<<<<<< create app directory >>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<<<< download app content >>>>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<< unzip app content>>>>>>>>>>>>\e[0m"
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<<< install app dependinces >>>>>>>>>>>\e[0m"
npm install

echo -e "\e[32m<<<<<<<<<<<<<< copy catalogue service >>>>>>>>>>>\e[0m"
cp $script_path/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[32m<<<<<<<<<<<<<< start catalogue service >>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

echo -e "\e[32m<<<<<<<<<<<<< copy mongo repos >>>>>>>>>>>\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m<<<<<<<<<<< install mongodb >>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32m<<<<<<<<<<<<< load mongo schema >>>>>>>>>>>>\e[0m"
mongo --host mongodb-dev.akrdevopsb72.online </app/schema/catalogue.js
