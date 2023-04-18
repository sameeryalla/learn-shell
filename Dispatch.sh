echo -e "\e[36m install go lang \e[0m"
yum install golang -y
echo -e "\e[36m add application user \e[0m"
useradd roboshop
echo -e "\e[36m create app directory \e[0m"
mkdir /app 
echo -e "\e[36m Download the application code to created app directory \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 
unzip /tmp/dispatch.zip
echo -e "\e[36m download the dependencies & build the software \e[0m"
cd /app 
go mod init dispatch
go get 
go build
echo -e "\e[36m move service file to default path \e[0m"
sudo cp /home/centos/learn-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "\e[36m start systemd service \e[0m"
systemctl daemon-reload
echo -e "\e[36m Enable and start the dispatch service \e[0m"
systemctl enable dispatch 
systemctl start dispatch
echo -e "\e[36m End of dispatch module installation \e[0m"

 