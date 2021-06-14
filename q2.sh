#!/bin/bash
echo >> "$1"
echo -n > q2_output.txt
while read line
do
for str in $line
do
if [[ $str = [a-zA-Z]* ]]
then
echo -n "$str " >> q2_output.txt
else
d=`echo $str | cut -c1-2`
m=`echo $str | cut -c4-5`
y=`echo $str | cut -c7-10`
a=`date "+%Y"`
b=`date "+%m"`
c=`date "+%d"`
if [ $y -le $a ]
then
e=$((a-y))
if [ $m -gt $b ]
then
e=`expr $e - 1`
elif [ $m == $b ]
then 
if [ $d -gt $c ]
then
e=$((e-1))
fi
fi
fi
fi
done
echo $e >> q2_output.txt
done < "$1"


