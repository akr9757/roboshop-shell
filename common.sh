app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

func_print_head() {
  echo -e '\e[36m>>>>>>>>>> $1 <<<<<<<<<<<\e[0m'
}

func_nodejs() {
  func_print_head "download nodejs repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "install nodejs"
  yum install nodejs -y

  func_print_head "add application user"
  useradd ${app_user}

  func_print_head "create app directory"
  rm -rf /app
  mkdir /app

  func_print_head "download app content"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app

  func_print_head "unzip app content"
  unzip /tmp/${component}.zip

  func_print_head "install dependencies"
  cd /app
  npm install

  func_print_head "copy ${component} service"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  func_print_head "start user service"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}
}
