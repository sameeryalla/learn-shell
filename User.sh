script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m<<<<<< download modeJ setup>>>>>>\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m<<<<<< Install nodejs>>>>>>\e[0m" 
yum install nodejs -y
echo -e "\e[36m<<<<<< add roboshop user >>>>>>\e[0m" 
useradd ${app_user}
echo -e "\e[36m<<<<<< create app directory>>>>>>\e[0m" 
mkdir /app 
echo -e "\e[36m<<<<<< download user module source code>>>>>>\e[0m" 
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
echo -e "\e[36m<<<<<< navigate to app folder and unzip user module source code>>>>>>\e[0m" 
cd /app 
unzip /tmp/user.zip
echo -e "\e[36m<<<<<< install npm>>>>>>\e[0m" 
npm install 
echo -e "\e[36m<<<<<< copy user service file to /etc/systemd/system/user.service>>>>>>\e[0m" 
cp ${script_path}/user.service /etc/systemd/system/user.service
echo -e "\e[36m<<<<<< reload the user service>>>>>>\e[0m" 
sudo systemctl daemon-reload
sudo systemctl enable user 
sudo systemctl start user
echo -e "\e[36m<<<<<< copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo>>>>>>\e[0m" 
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m<<<<<< Install mongodb shell>>>>>>\e[0m" 
yum install mongodb-org-shell -y
echo -e "\e[36m<<<<<< load mongodb schema>>>>>>\e[0m" 
mongo --host mongodb.sameerdevops.online </app/schema/user.js
echo -e "\e[36m<<<<<< end of user module installation >>>>>>\e[0m"