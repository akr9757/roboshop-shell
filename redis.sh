script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


echo -e "\e[32m<<<<<<<<<<< redis repos >>>>>>>>>>\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[32m<<<<<<<<<<<<<< enable redis >>>>>>>>>>\e[0m"
dnf module enable redis:remi-6.2 -y

echo -e "\e[32m<<<<<<<<<<< install redis >>>>>>>>>>>\e[0m"
yum install redis -y

echo -e "\e[32m<<<<<<<<<<<<< update liten address >>>>>>>>>>>\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf


echo -e "\e[32m<<<<<<<<<<< start redis >>>>>>>>>>>\e[0m"
systemctl enable redis
systemctl restart redis