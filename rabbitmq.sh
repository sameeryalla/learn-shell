REALPATH=$(realpath "$0")
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh

rabbitmq_app_password=$1
if [ -z "$rabbitmq_app_password" ]; then
   echo rabbitmq app password input is missing
   exit
fi




func_print_head " Install erlang from source url" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log_file}
func_status_check $?
yum install erlang -y &>>${log_file}
func_status_check $?
func_print_head " Configure YUM Repos for RabbitMQ" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log_file}
func_status_check $?
func_print_head " Install RabbitMQ"
yum install rabbitmq-server -y  &>>${log_file}
func_status_check $?
func_print_head " enable and starting RabbitMQ service" 
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server  &>>${log_file}
func_status_check $?
func_print_head " need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf " 
#rabbitmqctl add_user roboshop roboshop123
rabbitmqctl add_user roboshop ${rabbitmq_app_password} &>>${log_file}
func_status_check $?
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}
func_status_check $?
func_print_head " restarting RabbitMQ service" 
systemctl restart rabbitmq-server  &>>${log_file}
func_status_check $?