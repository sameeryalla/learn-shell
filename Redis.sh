REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=redis

func_print_head " Install Redis from source url" 
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
func_print_head " Enable Redis 6.2 from package streams." 
dnf module enable redis:remi-6.2 -y
func_print_head " Install Redis" 
yum install redis -y 
func_print_head " enable and starting redis service" 
systemctl enable redis 
systemctl start redis 
func_print_head " need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf " 
sed -i -e 's|127.0.0.1|0.0.0.0|g' /etc/redis.conf
func_print_head "restart redis service" 
systemctl restart redis