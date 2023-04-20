REALPATH=${realpath "$0"}
script_path=$(dirname "$REALPATH")
source ${script_path}/common.sh
component=catalogue

echo -e "\e[36m<<<<<< setting up catalogue module through function using component variable>>>>>>\e[0m"
#function declared in common.sh
func_nodejs
echo -e "\e[36m<<<<<< copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo>>>>>>\e[0m" 
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m<<<<<< Install mongodb shell>>>>>>\e[0m" 
yum install mongodb-org-shell -y
echo -e "\e[36m<<<<<< load mongodb schema>>>>>>\e[0m" 
mongo --host mongodb.sameerdevops.online </app/schema/catalogue.js
echo -e "\e[36m<<<<<< Successfully done catalogue setup>>>>>>\e[0m" 