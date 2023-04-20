REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
#password:roboshop123
rabbitmq_app_password=$1

echo -e "\e[36m<<<<<< install python 3.6 >>>>>>\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[36m<<<<<< useradd ${app_user} >>>>>>\e[0m"
useradd ${app_user}
echo -e "\e[36m<<<<<< setup an app directory >>>>>>\e[0m"
mkdir /app
echo -e "\e[36m<<<<<< download payment source and unzip files >>>>>>\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app
echo -e "\e[36m<<<<<< unzip the payment module files >>>>>>\e[0m" 
unzip /tmp/payment.zip
echo -e "\e[36m<<<<<< download dependencies >>>>>>\e[0m"
cd /app 
pip3.6 install -r requirements.txt
echo -e "\e[36m<<<<<< copy payment service to systemd directory >>>>>>\e[0m"
sed -i -e "S|rabbitmq_app_password|${rabbitmq_app_password}|" ${script_path}/payment.service
#sudo cp /home/centos/learn-shell/payment.service /etc/systemd/system/payment.service
sudo cp ${script_path}/payment.service /etc/systemd/system/payment.service
echo -e "\e[36m<<<<<< load systemd >>>>>>\e[0m"
systemctl daemon-reload
echo -e "\e[36m<<<<<< start the service >>>>>>\e[0m"
systemctl enable payment 
systemctl start payment
echo -e "\e[36m<<<<<< end of payment module installation >>>>>>\e[0m"