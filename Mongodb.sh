#copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo
mv mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
systemctl enable mongod 
systemctl start mongod 
#need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongos.conf
systemctl restart mongod