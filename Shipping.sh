echo -e "\e[36m install java maven dependency\e[0m" 
yum install maven -y
echo -e "\e[36m add roboshop user \e[0m" 
useradd roboshop
echo -e "\e[36m create app directory\e[0m" 
mkdir /app 
echo -e "\e[36m download shipping source code\e[0m" 
curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
echo -e "\e[36m navigate to app folder and unzip shipping source code\e[0m" 
cd /app 
unzip /tmp/shipping.zip
echo -e "\e[36m Lets download the dependencies & build the application\e[0m" 
cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 
echo -e "\e[36m copy shipping service file to /etc/systemd/system/shipping.service\e[0m" 
sudo cp /home/centos/learn-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[36m reload the shipping service\e[0m" 
systemctl daemon-reload
systemctl enable shipping 
systemctl start shipping
echo -e "\e[36m install sql\e[0m" 
yum install mysql -y
echo -e "\e[36m load schema\e[0m" 
mysql -h mysql.sameerdevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql 
echo -e "\e[36m restart the shipping service\e[0m"  
systemctl restart shipping
echo -e "\e[36m end of shipping module installation \e[0m"