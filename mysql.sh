REALPATH=$(realpath "$0")
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
mysql_root_pwd=$1

if [ -z "$mysql_root_pwd" ];then
  echo missing root password input
  exit 1
fi

func_print_head " lets disable MySQL 8 version."
dnf module disable mysql -y &>>${log_file}
func_status_check $?

func_print_head " copy mysql repo file to the path /etc/yum.repos.d/mongo.repo"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
func_status_check $?
func_print_head " Install mysql server"
yum install mysql-community-server -y &>>${log_file}
func_status_check $?
func_print_head " enable and starting sql service"
systemctl enable mysqld
systemctl start mysqld &>>${log_file}
func_status_check $?
func_print_head " We need to change the default root password in order to start using the database service "
sudo mysql_secure_installation --set-root-pass ${mysql_root_pwd} &>>${log_file}
func_status_check $?
func_print_head " restart mysqld service"
systemctl restart mysqld &>>${log_file}
func_status_check $?