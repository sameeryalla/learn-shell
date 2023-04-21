REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=frontend

func_print_head "Install nginx" 
yum install nginx -y 
func_print_head "enable nginx service" 
systemctl enable nginx
func_print_head "remove existing nginx html code" 
rm -rf /usr/share/nginx/html/* 
func_print_head "get Roboshop html files for frontend" 
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip 
func_print_head "unzip downloaded html setup" 
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
func_print_head copy "roboshop config file" 
sudo cp /home/centos/learn-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
func_print_head "restart nginx service"  
systemctl restart nginx