echo -e "\e[32m<<<<<<<<<<< insatll python >>>>>>>>>>\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[32m<<<<<<<<<<< add application user >>>>>>>>>>>|e[0m"
useradd roboshop

echo -e "\e[32m<<<<<<<<<<<< create app directory >>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<<<<<< download app content >>>>>>>>>>>>\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<<< unzip app content >>>>>>>>>>>>\e[0m"
unzip /tmp/payment.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>>\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[32m<<<<<<<<<<<< copy payment service >>>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service
systemctl daemon-reload

echo -e "\e[32m<<<<<<<<<<<<< start payment service >>>>>>>>>>>>\e[0m"
systemctl enable payment
systemctl restart payment