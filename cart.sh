script=$(realpath "$0")

exit
script-path=$(dirname "$script")
source ${script-path}/common.sh

echo -e "\e[32m<<<<<<<<<<<<< download nodejs repos >>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m<<<<<<<<<< install nodejs >>>>>>>>>>\e[0m"
yum install nodejs -y

echo -e "\e[32m<<<<<<<<<<<<<<< add application user >>>>>>>>>>>\e[0m"
useradd ${app-user}

echo -e "\e[32m<<<<<<<<<<<<< create app directory >>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<<<< download app content >>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<< unzip app content >>>>>>>>>>\e[0m"
unzip /tmp/cart.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>\e[0m"
npm install

echo -e "\e[32m<<<<<<<<<<<< copy cart service >>>>>>>>>>>\e[0m"
cp ${script-path}/cart.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart
systemctl restart cart