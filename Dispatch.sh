REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component="dispatch"





func_print_head " install go lang "
yum install golang -y &>>${log_file}
func_status_check $?
func_app_prereq
func_print_head " download the dependencies & build the software "
go mod init dispatch
go get 
go build &>>${log_file}
func_status_check $?
func_systemd_setup
func_print_head " End of dispatch module installation "

 