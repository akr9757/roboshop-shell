script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[32m<<<<<<<<<<< install golang >>>>>>>>>>\e[0m"
yum install golang -y

echo -e "\e[32m<<<<<<<<<<<< add application user >>>>>>>>>>>>\e[0m"
useradd ${app_user}

echo -e "\e[32m<<<<<<<<<<< create app directory >>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<< download app content >>>>>>>>>>>>\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<<< unzip app content >>>>>>>>>\e[0m"
unzip /tmp/dispatch.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>>\e[0m"
go mod init dispatch
go get
go build

echo -e "\e[32m<<<<<<<<<<<<<<< copy dispatch service >>>>>>>>>>>>\e[0m"
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service
systemctl daemon-reload

echo -e "\e[32m<<<<<<<<<<< start dispatch service >>>>>>>>\e[0m"
systemctl enable dispatch
systemctl restart dispatch