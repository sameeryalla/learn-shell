REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
#password:roboshop123
rabbitmq_app_password=$1
component="payment"

func_python