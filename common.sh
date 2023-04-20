app_user=roboshop



func_nodejs
{
    echo -e "\e[36m<<<<<< download modeJ setup>>>>>>\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m<<<<<< Install nodejs>>>>>>\e[0m" 
yum install nodejs -y
echo -e "\e[36m<<<<<< add roboshop user >>>>>>\e[0m" 
useradd ${app_user}
echo -e "\e[36m<<<<<< create app directory>>>>>>\e[0m" 
mkdir /app 
echo -e "\e[36m<<<<<< download ${component} source code>>>>>>\e[0m" 
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
echo -e "\e[36m<<<<<< navigate to app folder and unzip ${component} source code>>>>>>\e[0m" 
cd /app 
unzip /tmp/${component}.zip
echo -e "\e[36m<<<<<< install npm>>>>>>\e[0m" 
npm install 
echo -e "\e[36m<<<<<< copy ${component} service file to /etc/systemd/system/${component}.service>>>>>>\e[0m" 
#cp /home/centos/learn-shell/${component}.service /etc/systemd/system/${component}.service
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
echo -e "\e[36m<<<<<< reload the ${component} service>>>>>>\e[0m" 
sudo systemctl daemon-reload
sudo systemctl enable ${component} 
sudo systemctl start ${component}
}