echo -e "\e32m<<<<<<<<<< disable mysql >>>>>>>>>\e[0m"
dnf module disable mysql -y

echo -e "\e32m<<<<<<<<<<<<<<< copy mysql repos >>>>>>>>>>\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e32m<<<<<<<<<<<<< install mysql >>>>>>>>>\e[0m"
yum install mysql-community-server -y

echo -e "\e32m<<<<<<<<<< start mysql service >>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e32m<<<<<<<<<< set root password >>>>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1