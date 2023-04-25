#case_command
fruit $1
case $fruit in
	apple)
	     echo price - 10$
	;;
	banana)
	     echo price - .5$
	;;
	orange)
	     echo price - 5$
	;;
	*)
	     echo fruit not found
	;;
esac
	