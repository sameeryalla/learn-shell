#if-else
fruit_name=$1
qty=$2

if [-z "$qty"]; then
   echo input is missing
   exit
fi
   
if [ "$fruit_name" == "mango" ]; then
	echo mango qualtity is ${qty}
else
    echo no such fruit
fi
	
	
if [ "$qty" -lt 10]; then
   echo mango price .5$
elif [ "$qty" -lt 30]; then
   echo mango price .25$
elif [ "$qty" -gt 50]; then
   echo mango price .15$
else
   echo mango price .5$
fi 