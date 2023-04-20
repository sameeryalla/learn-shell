A=10
NAME=DevOps

#print variables
echo A=$A
echo NAME=${NAME}

#date value
#DATE=2023-04-18
DATE=${date +%F}
echo Todays date is ${DATE}

ARTH=$((2-3*4/2))
echo ARTH=${ARTH}

#special variables for inputs
echo script name-"$0"
echo first_Argument-"$1"
echo Second_Argument-"$2"
echo ALL_ARGUMENTS-"$*"
echo no.of Arguments-"$#"

