echo -e "\e[36m<<<<<< Install Redis from source url>>>>>>\e[0m" 
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo -e "\e[36m<<<<<< Enable Redis 6.2 from package streams.>>>>>>\e[0m" 
dnf module enable redis:remi-6.2 -y
echo -e "\e[36m<<<<<< Install Redis>>>>>>\e[0m" 
yum install redis -y 
echo -e "\e[36m<<<<<< enable and starting redis service>>>>>>\e[0m" 
systemctl enable redis 
systemctl start redis 
echo -e "\e[36m<<<<<< need to modify the bind path 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf >>>>>>\e[0m" 
sed -i -e 's|127.0.0.1|0.0.0.0|g' /etc/redis.conf
echo -e "\e[36m<<<<<< restart redis service>>>>>>\e[0m" 
systemctl restart redis