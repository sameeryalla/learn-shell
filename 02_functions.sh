#functions

function_name1()
{
	echo First Argument=$1
	echo Second Argument=$2
	echo All Arguments=$*
	echo No of Argument=$#
	func_print_head $* " 
}

function_name1 Sameer Yalla