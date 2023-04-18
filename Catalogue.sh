echo -e "\e[36m<<<<<< download modeJ setup>>>>>>\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m<<<<<< Install nodejs>>>>>>\e[0m" 
yum install nodejs -y
echo -e "\e[36m<<<<<< add roboshop user >>>>>>\e[0m" 
useradd roboshop
echo -e "\e[36m<<<<<< create app directory>>>>>>\e[0m" 
mkdir /app 
echo -e "\e[36m<<<<<< download catalogue source code>>>>>>\e[0m" 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
echo -e "\e[36m<<<<<< navigate to app folder and unzip catalogue source code>>>>>>\e[0m" 
cd /app 
unzip /tmp/catalogue.zip
echo -e "\e[36m<<<<<< install npm>>>>>>\e[0m" 
npm install 
echo -e "\e[36m<<<<<< copy catalogue service file to /etc/systemd/system/catalogue.service>>>>>>\e[0m" 
cp /home/centos/learn-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m<<<<<< reload the catalogue service>>>>>>\e[0m" 
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue
echo -e "\e[36m<<<<<< copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo>>>>>>\e[0m" 
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m<<<<<< Install mongodb shell>>>>>>\e[0m" 
yum install mongodb-org-shell -y
echo -e "\e[36m<<<<<< load mongodb schema>>>>>>\e[0m" 
mongo --host mongodb.sameerdevops.online </app/schema/catalogue.js