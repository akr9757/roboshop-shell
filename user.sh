script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=user
schema-setup=mongo

func_nodejs

echo -e "\e[32m<<<<<<<<<<<< copy mongo repos >>>>>>>>>\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m<<<<<<<<<<<< install mongodb >>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32m<<<<<<<<<< load mongod schema >>>>>>>>>\e[0m"
mongo --host mongodb-dev.akrdevopsb72.online </app/schema/user.js