#!/bin/bash
cat "$1" > input.txt
sed -n -r '/\S/!d' "$1"
echo >> input.txt
while read lines
do
for str in $lines
do
sed -i "s/\b$str[ \!@#$%^&*()_+.,?\/]//g" input.txt
done
done < "$2"
sed -n 's/ \+/ /g' input.txt
touch output.txt
echo -n > output.txt
while read line
do
i=0
j=0
for str in $line
do
if [[ $str == [a-zA-Z0-9]* ]]
then
i=$((i+1))
fi
if [[ $str =~ ['\!@#$%^&*()_+.,?\/'] ]]
then 
str=`echo "${str%?}"` 
fi
if [[ $3 == $str ]]
then
j=$((j+1))
fi
done
echo -n $line >> output.txt
echo -n ", " >> output.txt
if [ $i == 0 ]
then
echo 0 >> output.txt
elif [[ $i = $j ]]
then
echo 1 >> output.txt
else
echo -n 0 >> output.txt
bc -l <<< "scale=2; $j / $i " >> output.txt
fi
done < input.txt
cat output.txt
rm input.txt
rm output.txt