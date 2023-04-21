app_user=roboshop
log_file=/tmp/Roboshop.log


func_print_head()
{
	echo -e "\e[36m>>>>>> $* <<<<<<<<<<\e[0m"
	echo -e "\e[36m>>>>>> $* <<<<<<<<<<\e[0m" &>>${log_file}
}


func_status_check()
{
  if [ $1 -eq 0 ]; then
      echo -e "\e[32m SUCCESS \e[0m"
    else
      echo -e "\e[31m FAILED, refer the log file ${log_file} for more information \e[0m"

      exit 1
  fi
}


func_app_prereq()
{
    id ${app_user} &>>${log_file}
    if [ $? -ne 0 ]; then
       func_print_head " add ${app_user} user "
           useradd ${app_user} &>>${log_file}
           func_status_check $?
    fi

    func_print_head " create application directory"
    rm -rf /app &>>${log_file}
    mkdir /app &>>${log_file}
    func_status_check $?
    func_print_head " download ${component} source code"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
    func_status_check $?
    func_print_head " navigate to app folder and unzip $component source code"
    cd /app
    unzip /tmp/${component}.zip &>>${log_file}
    func_status_check $?

}

func_systemd_setup()
{
  #sudo cp /home/centos/learn-shell/dispatch.service /etc/systemd/system/dispatch.service
  func_print_head " copy ${component} service file to /etc/systemd/system/${component}.service"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
  func_status_check $?
  func_print_head " reload the ${component} service"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component}
  systemctl start ${component}
  func_status_check $?
}

func_schema_setup()
{
  if [ "$schema_setup" == "mongo" ]; then
      func_print_head copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo
      cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo &>${log_file}
      func_status_check $?
      func_print_head Install mongodb shell
      yum install mongodb-org-shell -y &>>${log_file}
      func_status_check $?
      func_print_head load mongodb schema
      mongo --host mongodb.sameerdevops.online </app/schema/${component}.js &>>${log_file}
      func_status_check $?
      elif [ "$schema_setup" == "mysql" ]; then
          func_print_head " install sql"
          yum install mysql -y &>>${log_file}
          func_status_check $?
          func_print_head " load schema"
          #mysql -h mysql.sameerdevops.online -uroot -pRoboShop@1 < /app/schema/${component}.sql
          mysql -h mysql.sameerdevops.online -uroot -p${mysql_root_pwd} < /app/schema/${component}.sql &>>${log_file}
          func_status_check $?
	fi
}


func_nodejs()
{
	func_print_head download modeJ setup
	curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
	func_print_head Install nodejs
	yum install nodejs -y &>>${log_file}
	func_status_check $?
	func_app_prereq
	func_print_head "install npm"
	npm install &>${log_file}
	func_status_check $?
	func_schema_setup
	func_status_check $?
	func_systemd_setup
}




func_java()
{
  func_print_head " install java maven dependency"
  yum install maven -y &>>${log_file}
  func_status_check $?
  func_app_prereq
  func_print_head " Lets download the dependencies & build the application"
  cd /app
  mvn clean package &>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}
  func_systemd_setup
  func_status_check $?
  func_schema_setup
  func_status_check $?
  func_print_head " restart the ${component} service"
  systemctl restart ${component} &>>${log_file}
}

func_python()
{
	func_print_head " install python 3.6 "
	yum install python36 gcc python3-devel -y &>>${log_file}
	func_status_check $?
	func_print_head " useradd ${app_user} "
	func_app_prereq
	func_print_head " download dependencies "
	cd /app 
	pip3.6 install -r requirements.txt &>>${log_file}
	func_status_check $?
	func_print_head " copy ${component} service to systemd directory "
	sed -i -e "S|rabbitmq_app_password|${rabbitmq_app_password}|" ${script_path}/${component}.service
	func_status_check $?
	func_systemd_setup
	func_print_head " end of ${component} module installation "
}

