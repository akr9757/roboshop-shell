echo -e "\e32m<<<<<<<<< copy mongo repos >>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e32m<<<<<<<<<< install mongodb >>>>>>>>>>\e[0m"
yum install mongodb-org -y

echo -e "\e32m<<<<<<<<<< start mongodb >>>>>>>>>\e[0m"
systemctl enable mongod
systemctl restart mongod

sed -e -i 's|127.0.0.0|0.0.0.0|' /etc/mongo.conf

systemctl restart mongod