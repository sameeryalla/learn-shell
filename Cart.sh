REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=cart

func_print_head " setting up cart module through function using component variable"
#function declared in common.sh
func_nodejs
func_print_head " end of cart module installation "
