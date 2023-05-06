echo -e "\e32m<<<<<<<<<<< install golang >>>>>>>>>>\e[0m"
yum install golang -y

echo -e "\e32m<<<<<<<<<<<< add application user >>>>>>>>>>>>\e[0m"
useradd roboshop

echo -e "\e32m<<<<<<<<<<< create app directory >>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e32m<<<<<<<<<< download app content >>>>>>>>>>>>\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e32m<<<<<<<<<<<<<< unzip app content >>>>>>>>>\e[0m"
unzip /tmp/dispatch.zip
cd /app

echo -e "\e32m<<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>>\e[0m"
go mod init dispatch
go get
go build

echo -e"\e32m<<<<<<<<<<<<<<< copy dispatch service >>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch