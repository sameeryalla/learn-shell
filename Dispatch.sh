REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh

func_print_head " install go lang "
yum install golang -y
func_print_head " add application user "
useradd ${app_user}
func_print_head " create app directory "
mkdir /app 
func_print_head " Download the application code to created app directory "
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 
unzip /tmp/dispatch.zip
func_print_head " download the dependencies & build the software "
cd /app 
go mod init dispatch
go get 
go build
func_print_head " move service file to default path "
#sudo cp /home/centos/learn-shell/dispatch.service /etc/systemd/system/dispatch.service
sudo cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service
func_print_head " start systemd service "
systemctl daemon-reload
func_print_head " Enable and start the dispatch service "
systemctl enable dispatch 
systemctl start dispatch
func_print_head " End of dispatch module installation "

 