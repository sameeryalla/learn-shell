REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=catalogue
schema_setup=mongo

func_print_head "setting up catalogue module through function using component variable"
#function declared in common.sh
func_nodejs
func_print_head "Successfully done $component set up"