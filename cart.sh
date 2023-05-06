echo -e "\e32m<<<<<<<<<<<<< download nodejs repos >>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e32m<<<<<<<<<< install nodejs >>>>>>>>>>\e[0m"
yum install nodejs -y

echo -e "\e32m<<<<<<<<<<<<<<< add application user >>>>>>>>>>>\e[0m"
useradd roboshop

echo -e "\e32m<<<<<<<<<<<<< create app directory >>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e32m<<<<<<<<<<<< download app content >>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e32m<<<<<<<<<<<<< unzip app content >>>>>>>>>>\e[0m"
unzip /tmp/cart.zip
cd /app

echo -e "\e32m<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>\e[0m"
npm install

echo -e "\e32m<<<<<<<<<<<< copy cart service >>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart
systemctl restart cart