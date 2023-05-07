echo -e "\e[32m<<<<<<<<<<<<< install maven >>>>>>>>>>\e[0m"
yum install maven -y

echo -e "\e[32m<<<<<<<<<<<<< add application user >>>>>>>>>>>\e[0m"
useradd roboshop

echo -e "\e[32m<<<<<<<<<<<< create app directory >>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m<<<<<<<<<<<< download app content >>>>>>>>>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<<< unzip app content >>>>>>>>>>>>\e[0m"
unzip /tmp/shipping.zip
cd /app

echo -e "\e[32m<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[32m<<<<<<<<<<<< copy shipping service >>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping

echo -e "\e[32m<<<<<<<<<< install mysql >>>>>>>>\e[0m"
yum install mysql -y

echo -e "\e[32m<<<<<<<<<<<<< load mysql schema >>>>>>>>>>>>>\e[0m"
mysql -h mysql-dev.akrdevopsb72.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping