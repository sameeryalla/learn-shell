curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 
unzip /tmp/catalogue.zip
npm install 
 # copy catalogue service file to /etc/systemd/system/catalogue.service
 cp catalogue.service /etc/systemd/system/catalogue.service
 systemctl daemon-reload
 systemctl enable catalogue 
systemctl start catalogue
#copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo
mv mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongod.sameerdevops.online </app/schema/catalogue.js