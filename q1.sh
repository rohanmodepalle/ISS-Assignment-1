#!/bin/bash
echo >> "$1"
echo -n > q1_output.txt
while read line 
do
a=`echo $line | cut -c1-4`
b=`echo $line | cut -c5-`
printf "%s%s\n" "$a" "${b//?/#}" >> q1_output.txt
done < "$1"


