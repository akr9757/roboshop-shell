script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

echo -e "\e[32m<<<<<<<<<<<<< install python >>>>>>>>>>>\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[32m<<<<<<<<<<<<< add application user >>>>>>>>>>>\e[0m"
useradd ${app_user}

echo -e "\e[32m<<<<<<<<<<<<< create app directory >>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<<<<< download app content >>>>>>>>>>>\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[32m<<<<<<<<<<<<< extract app content >>>>>>>>>>>\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[32m<<<<<<<<<<<<< install dependencies >>>>>>>>>>>\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[32m<<<<<<<<<<<<< copy payment service >>>>>>>>>>>\e[0m"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service

echo -e "\e[32m<<<<<<<<<<<<< load payment service >>>>>>>>>>>\e[0m"
systemctl daemon-reload

echo -e "\e[32m<<<<<<<<<<<<< start payment service >>>>>>>>>>>\e[0m"
systemctl enable payment
systemctl restart payment