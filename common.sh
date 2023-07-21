app_user=roboshop

func_nodejs() {
  echo -e "\e[32m<<<<<<<<<<<<< download nodejs repos >>>>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  echo -e "\e[32m<<<<<<<<<< install nodejs >>>>>>>>>>\e[0m"
  yum install nodejs -y

  echo -e "\e[32m<<<<<<<<<<<<<<< add application user >>>>>>>>>>>\e[0m"
  useradd ${app_user}

  echo -e "\e[32m<<<<<<<<<<<<< create app directory >>>>>>>>>>>>\e[0m"
  rm -rf /app
  mkdir /app

  echo -e "\e[32m<<<<<<<<<<<< download app content >>>>>>>>>>>>>\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app

  echo -e "\e[32m<<<<<<<<<<<<< unzip app content >>>>>>>>>>\e[0m"
  unzip /tmp/${component}.zip

  echo -e "\e[32m<<<<<<<<<<<<< install dependencies >>>>>>>>>>>>\e[0m"
  cd /app
  npm install

  echo -e "\e[32m<<<<<<<<<<<< copy ${component} service >>>>>>>>>>>\e[0m"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  echo -e "\e[32m<<<<<<<<<<<<<< start user service >>>>>>>>>\e[0m"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}
}
