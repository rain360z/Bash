#!/bin/bash
# List ip address tunneled
strACL=`csconf_mgr show | grep 'permit ip' | grep -Eo '[1-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
# Create array List
declare -a array
# Cicle add element in arrai List
for var in $strACL
do
array+=($var)
done
# Number Element array
numberarray=0
for i in ${array[*]}; do
 IFS=.
 err=($i)
 echo "1) view all array ip address"
 echo ${err[@]}
 echo "2) view 4 oktet ip address"
 echo ${err[3]}
 echo "3) view change 4 okete"
 err[3]=$((${err[3]}+1))
 echo "${err[3]}"
 echo "4) view all array err"
 echo "${err[@]}"
 IFS=
 ipaddr="${err[0]}.${err[1]}.${err[2]}.${err[3]}"
 echo $ipaddr
 array[numberarray]=$ipaddr
 numberarray+=1
done
echo ${array[@]}
echo "lengh array"
lengharray=${#array[@]}
echo $lengharray
for ((i = 0; i<=lengharray; i=i+2))
do
twoip=i+1
ping -c 3 -i 0.01 -s 18000 -I ${array[i]} ${array[twoip]}; echo $?
done

