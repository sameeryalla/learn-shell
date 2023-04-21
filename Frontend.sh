REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=frontend

func_print_head "Install nginx" 
yum install nginx -y  &>>${log_path}
func_status_check $?
func_print_head "enable nginx service" 
systemctl enable nginx &>>${log_path}
func_status_check $?
func_print_head "remove existing nginx html code" 
rm -rf /usr/share/nginx/html/*  &>>${log_path}
func_status_check $?
func_print_head "get Roboshop html files for frontend"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log_path}
func_status_check $?
func_print_head "unzip downloaded html setup" 
cd /usr/share/nginx/html  &>>${log_path}
unzip /tmp/frontend.zip &>>${log_path}
func_status_check $?
func_print_head copy "roboshop config file"
cp /home/centos/learn-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_path}
func_status_check $?
func_print_head "restart nginx service"  
systemctl restart nginx &>>${log_path}
func_status_check $?