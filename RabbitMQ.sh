rabbitmq_app_password=$1
if [-z "$rabbitmq_app_password"]; then
   echo rabbitmq app password input is missing
   exit
fi

echo -e "\e[36m<<<<<< Install erlang from source url>>>>>>\e[0m" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
yum install erlang -y
echo -e "\e[36m<<<<<< Configure YUM Repos for RabbitMQ>>>>>>\e[0m" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[36m<<<<<< Install RabbitMQ>>>>>>\e[0m"
yum install rabbitmq-server -y 
echo -e "\e[36m<<<<<< enable and starting RabbitMQ service>>>>>>\e[0m" 
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server  
echo -e "\e[36m<<<<<< need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf >>>>>>\e[0m" 
#rabbitmqctl add_user roboshop roboshop123
rabbitmqctl add_user roboshop ${rabbitmq_app_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
echo -e "\e[36m<<<<<< restarting RabbitMQ service>>>>>>\e[0m" 
systemctl restart rabbitmq-server 