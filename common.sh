app_user=roboshop


func_print_head()
{
	echo -e "\e[36m>>>>>> $* <<<<<<<<<<\e[0m" 
}


func_app_prereq()
{
    func_print_head " add ${app_user} user "
    useradd ${app_user}
    func_print_head " create application directory"
    mkdir /app
    func_print_head " download ${component} source code"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    func_print_head " navigate to app folder and unzip $component source code"
    cd /app
    unzip /tmp/${component}.zip

}

func_systemd_setup()
{
  func_print_head " copy ${component} service file to /etc/systemd/system/${component}.service"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
  func_print_head " reload the ${component} service"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}
}

func_schema_setup()
{
    if [ "$schema_setup"="mongo" ] ;
	then
		func_print_head copy mongodb repo file to the path /etc/yum.repos.d/mongo.repo
		cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
		func_print_head Install mongodb shell
		yum install mongodb-org-shell -y
		func_print_head load mongodb schema
		mongo --host mongodb.sameerdevops.online </app/schema/${component}.js
		elif["$schema_setup"="mysql" ];
		then
		   func_print_head " install sql"
        yum install mysql -y
        func_print_head " load schema"
        #mysql -h mysql.sameerdevops.online -uroot -pRoboShop@1 < /app/schema/${component}.sql
        mysql -h mysql.sameerdevops.online -uroot -p${mysql_root_pwd} < /app/schema/${component}.sql
	fi
}


func_nodejs()
{
	func_print_head download modeJ setup
	curl -sL https://rpm.nodesource.com/setup_lts.x | bash
	func_print_head Install nodejs
	yum install nodejs -y
	func_app_prereq
	func_print_head "install npm"
	npm install 
	func_schema_setup
	func_systemd_setup
}



func_java()
{
  func_print_head " install java maven dependency"
  yum install maven -y
  func_app_prereq
   func_print_head " Lets download the dependencies & build the application"
      cd /app
      mvn clean package
      mv target/${component}-1.0.jar ${component}.jar
      func_systemd_setup
      func_schema_setup
  func_print_head " restart the ${component} service"
  systemctl restart ${component}
}

