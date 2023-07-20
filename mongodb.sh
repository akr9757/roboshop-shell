script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[32m<<<<<<<<< copy mongo repos >>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m<<<<<<<<<< install mongodb >>>>>>>>>>\e[0m"
yum install mongodb-org -y

echo -e "\e[32m<<<<<<<<<< start mongodb >>>>>>>>>\e[0m"
systemctl enable mongod
systemctl restart mongod

sed -i -e 's|127.0.0.0|0.0.0.0|' /etc/mongod.conf

systemctl restart mongod