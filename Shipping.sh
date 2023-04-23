REALPATH=$(realpath "$0")
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
mysql_root_pwd=$1
component="shipping"
schema_setup=mysql

if [-z "$mysql_root_pwd"]; then
   echo mysql root password input is missing
   exit
fi

func_java

func_print_head " end of shipping module installation "