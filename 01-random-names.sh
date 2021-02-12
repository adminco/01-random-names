#!/bin/bash

#Get and store json data from api 
json=$(curl https://reqres.in/api/users?page=1 2>&1)

#Clean data and store names
data=$(echo $json | sed -e 's/[{}]/''/g' | sed 's/,/\n/g' | grep name | awk 'BEGIN{FS=":"} {print $2}')

#Initialize array and store names in it
my_array=()
for i in $data; do 
	my_array+=("$i"); 
done

#Create a function that generates random unique even numbers and returns them
function genrandom () {
num=$(( $1/2 ))
array=()
while [ ${#array[@]} -lt $num ]
do
 new_num=$(( $num - 1 ))
 shuff=$(shuf -i 0-$new_num -n1 -r)
 rand=$(( $shuff * 2 ))
 if [[ ${array[@]} =~ (^|[[:space:]])"$rand"($|[[:space:]]) ]]
 then
    continue
 else
    #echo $rand
    array+=($rand)
 fi
done
echo "${array[@]}"
}

#Initialize another array to store random numbers by calling function
randomNumbers=($(genrandom ${#my_array[@]}))

#Run a loop which iterates through generated random numbers and prints <FIRST NAME> <LAST NAME> in random order
for (( i=0; i < $((${#my_array[@]}/2)); i++ )) 
do
	randomArray+=(${randomNumbers[i]})
	random=${randomArray[i]}
	echo "${my_array[$random]} ${my_array[$random+1]}" | sed 's/"//g'
done




