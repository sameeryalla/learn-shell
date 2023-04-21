REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=user
schema_setup=mongo

func_print_head " setting up user module through function using component variable" 
#function declared in common.sh
func_nodejs