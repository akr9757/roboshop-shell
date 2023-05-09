script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

echo -e "\e[32m<<<<<<<<<< disable mysql >>>>>>>>>\e[0m"
dnf module disable mysql -y

echo -e "\e[32m<<<<<<<<<<<<<<< copy mysql repos >>>>>>>>>>\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[32m<<<<<<<<<<<<< install mysql >>>>>>>>>\e[0m"
yum install mysql-community-server -y

echo -e "\e[32m<<<<<<<<<< start mysql service >>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[32m<<<<<<<<<< set root password >>>>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass ${mysql_root_password}