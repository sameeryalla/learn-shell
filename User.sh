echo -e "\e[36m download modeJ setup\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m Install nodejs\e[0m" 
yum install nodejs -y
echo -e "\e[36m add roboshop user \e[0m" 
useradd roboshop
echo -e "\e[36m create app directory\e[0m" 
mkdir /app 
echo -e "\e[36m download user module source code\e[0m" 
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
echo -e "\e[36m navigate to app folder and unzip user module source code\e[0m" 
cd /app 
unzip /tmp/user.zip
echo -e "\e[36m install npm\e[0m" 
npm install 
 echo -e "\e[36m copy user service file to /etc/systemd/system/user.service\e[0m" 
 cp user.service /etc/systemd/system/user.service
 echo -e "\e[36m reload the user service\e[0m" 
 systemctl daemon-reload
 systemctl enable user 
systemctl start user
echo -e "\e[36m copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo\e[0m" 
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m Install mongodb shell\e[0m" 
yum install mongodb-org-shell -y
echo -e "\e[36m load mongodb schema\e[0m" 
mongo --host mongod.sameerdevops.online </app/schema/user.js