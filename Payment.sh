REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
#password:roboshop123
rabbitmq_app_password=$1

func_print_head " install python 3.6 "
yum install python36 gcc python3-devel -y
func_print_head " useradd ${app_user} "
useradd ${app_user}
func_print_head " setup an app directory "
mkdir /app
func_print_head " download payment source and unzip files "
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app
func_print_head " unzip the payment module files " 
unzip /tmp/payment.zip
func_print_head " download dependencies "
cd /app 
pip3.6 install -r requirements.txt
func_print_head " copy payment service to systemd directory "
sed -i -e "S|rabbitmq_app_password|${rabbitmq_app_password}|" ${script_path}/payment.service
#sudo cp /home/centos/learn-shell/payment.service /etc/systemd/system/payment.service
sudo cp ${script_path}/payment.service /etc/systemd/system/payment.service
func_print_head " load systemd "
systemctl daemon-reload
func_print_head " start the service "
systemctl enable payment 
systemctl start payment
func_print_head " end of payment module installation "