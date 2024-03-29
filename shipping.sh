script=$(realpath $0)
script_path=$(dirname $script)
source ${script_path}/common.sh
mysql_root_password=$1

echo -e "\e[32m<<<<<<<<<<<<< install maven >>>>>>>>>>\e[0m"
yum install maven -y

echo -e "\e[32m<<<<<<<<<<<<< add application user >>>>>>>>>>>\e[0m"
useradd ${app_user}

echo -e "\e[32m<<<<<<<<<<<< create app directory >>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<<<< download app content >>>>>>>>>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<<< unzip app content >>>>>>>>>>>>\e[0m"
unzip /tmp/shipping.zip

echo -e "\e[32m<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[32m<<<<<<<<<<<< copy shipping service >>>>>>>>>>>>\e[0m"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping

echo -e "\e[32m<<<<<<<<<< install mysql >>>>>>>>\e[0m"
yum install mysql -y

echo -e "\e[32m<<<<<<<<<<<<< load mysql schema >>>>>>>>>>>>>\e[0m"
mysql -h mysql-dev.akrdevopsb72.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
