echo -e "\e[36m<<<<<< Install nginx>>>>>>\e[0m" 
yum install nginx -y 
echo -e "\e[36m<<<<<< enable nginx service>>>>>>\e[0m" 
systemctl enable nginx
echo -e "\e[36m<<<<<< remove existing nginx html code>>>>>>\e[0m" 
rm -rf /usr/share/nginx/html/* 
echo -e "\e[36m<<<<<< get Roboshop html files for frontend>>>>>>\e[0m" 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
echo -e "\e[36m<<<<<< unzip downloaded html setup>>>>>>\e[0m" 
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
echo -e "\e[36m<<<<<< copy roboshop config file>>>>>>\e[0m" 
sudo cp /home/centos/learn-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[36m<<<<<< restart nginx service>>>>>>\e[0m"  
systemctl restart nginx