REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh

echo -e "\e[36m<<<<<< lets disable MySQL 8 version.>>>>>>\e[0m" 
dnf module disable mysql -y 
echo -e "\e[36m<<<<<< copy mysql repo file to the path /etc/yum.repos.d/mongo.repo>>>>>>\e[0m" 
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m<<<<<< Install mysql server>>>>>>\e[0m" 
yum install mysql-community-server -y
echo -e "\e[36m<<<<<< enable and starting sql service>>>>>>\e[0m" 
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[36m<<<<<< We need to change the default root password in order to start using the database service >>>>>>\e[0m" 
mysql_secure_installation --set-root-pass RoboShop@1
echo -e "\e[36m<<<<<< restart mongod service>>>>>>\e[0m" 
systemctl restart mysqld