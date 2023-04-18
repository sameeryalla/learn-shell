echo -e "\e[36m copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo\e[0m" 
cp /home/centos/learn-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m Install mongodb\e[0m" 
yum install mongodb-org -y
echo -e "\e[36m enable and starting mongod service\e[0m" 
systemctl enable mongod 
systemctl start mongod 
echo -e "\e[36m need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf \e[0m" 
sed -i -e 's|127.0.0.1|0.0.0.0|g' /etc/mongod.conf
echo -e "\e[36m restart mongod service\e[0m" 
systemctl restart mongod