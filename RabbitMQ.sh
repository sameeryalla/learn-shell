rabbitmq_app_password=$1
if [-z "$rabbitmq_app_password"]; then
   echo rabbitmq app password input is missing
   exit
fi

func_print_head " Install erlang from source url" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
yum install erlang -y
func_print_head " Configure YUM Repos for RabbitMQ" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
func_print_head " Install RabbitMQ"
yum install rabbitmq-server -y 
func_print_head " enable and starting RabbitMQ service" 
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server  
func_print_head " need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf " 
#rabbitmqctl add_user roboshop roboshop123
rabbitmqctl add_user roboshop ${rabbitmq_app_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
func_print_head " restarting RabbitMQ service" 
systemctl restart rabbitmq-server 