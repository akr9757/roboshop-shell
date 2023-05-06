echo -e "\e32m<<<<<<<<< install nginx >>>>>>>>>>\e[0m"
yum install nginx -y

echo -e "\e32m<<<<<<<<< copy roboshop conf >>>>>>>>>>>\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf
rm -rf /usr/share/nginx/html/*

echo -e "\e32m<<<<<<<< download frontend content>>>>>>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html

echo -e "\e32m<<<<<<<<<< unzip frontend content >>>>>>>>\e[0m"
unzip /tmp/frontend.zip

echo -e "\e32m<<<<<<<<<<< start nginx service >>>>>>>>>\e[0m"
systemctl restart nginx
systemctl enable nginx