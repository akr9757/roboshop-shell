script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

echo -e "\e[32m<<<<<<<<<<< download rabbitmq repos >>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[32m<<<<<<<<<<<<<< install erlang >>>>>>>>>\e[0m"
yum install erlang -y

echo -e "\e[32m<<<<<<<<<<< download rabbitmq repos 2 >>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[32m<<<<<<<<<<< install rabbitmq >>>>>>>>>>>\e[0m"
yum install rabbitmq-server -y

rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

systemctl enable rabbitmq-server
systemctl restart rabbitmq-server