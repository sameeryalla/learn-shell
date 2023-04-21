REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh


func_print_head " copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo" 
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
func_print_head " Install mongodb" 
yum install mongodb-org -y
func_print_head " enable and starting mongod service" 
systemctl enable mongod 
systemctl start mongod 
func_print_head " need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf " 
sed -i -e 's|127.0.0.1|0.0.0.0|g' /etc/mongod.conf
func_print_head " restart mongod service" 
systemctl restart mongod