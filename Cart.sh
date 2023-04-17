echo -e "\e[36m download modeJ setup\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m Install nodejs\e[0m" 
yum install nodejs -y
echo -e "\e[36m add roboshop cart \e[0m" 
useradd roboshop
echo -e "\e[36m create app directory\e[0m" 
mkdir /app 
echo -e "\e[36m download cart module source code\e[0m" 
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
echo -e "\e[36m navigate to app folder and unzip cart module source code\e[0m" 
cd /app 
unzip /tmp/cart.zip
echo -e "\e[36m install npm\e[0m" 
npm install 
 echo -e "\e[36m copy cart service file to /etc/systemd/system/cart.service\e[0m" 
 sudo cp cart.service /etc/systemd/system/cart.service
 echo -e "\e[36m reload the cart service\e[0m" 
 systemctl daemon-reload
 systemctl enable cart 
systemctl start cart
echo -e "\e[36m copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo\e[0m" 
sudo cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m Install mongodb shell\e[0m" 
yum install mongodb-org-shell -y
echo -e "\e[36m load mongodb schema\e[0m" 
mongo --host mongodb.sameerdevops.online </app/schema/cart.js