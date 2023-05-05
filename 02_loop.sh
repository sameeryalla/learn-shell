#loops
#while loop:
a=10
while [ $a -gt 0 ]; do
	echo a - $a - greater than 0
	a=$(($a-1))
	sleep 1
done


for fruit in apple banana orange; do
	echo fruit name= $fruit
	sleep 1
done
