REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=cart

echo -e "\e[36m<<<<<< setting up cart module through function using component variable>>>>>>\e[0m"
#function declared in common.sh
func_nodejs
echo -e "\e[36m<<<<<< end of cart module installation >>>>>>\e[0m"
