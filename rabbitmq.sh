echo -e "\e32m<<<<<<<<<<< download rabbitmq repos >>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e32m<<<<<<<<<<<<<< install erlang >>>>>>>>>\e[0m"
yum install erlang -y

echo -e "\e32m<<<<<<<<<<< download rabbitmq repos 2 >>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e32m<<<<<<<<<<< install rabbitmq >>>>>>>>>>>\e[0m"
yum install rabbitmq-server -y
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"