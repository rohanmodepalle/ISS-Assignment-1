#!/bin/bash
while getopts ":C:k:f:l:n:o:v:adc:" fl;
do
case "${fl}" in
f) fname=${OPTARG};;
l) lname=${OPTARG};;
n) mobile=${OPTARG};;
C) op=${OPTARG};;
c) column=${OPTARG};;
v) search=${OPTARG};;
d) descending=1;;
a) ascending=1;;
o) office=${OPTARG};;
k) ename=${OPTARG};;
esac
done
touch contacts.csv
lines=$(cat contacts.csv | wc -l)
if [ $lines == 0 ]
then
echo "fname,lname,mobile,Office" > contacts.csv
fi

case "${op}" in
insert)
echo -n "" >> contacts.csv
echo "${fname},${lname},${mobile},${office}" >> contacts.csv;;

search)
if [[ "$column" == "fname" ]]
then
while IFS="," read -r a b c d
do
if [[ "$a" == "$search" ]]
then
echo $a,$b,$c,$d
fi
done < contacts.csv
elif [[ "$column" == "lname" ]]
then
while IFS="," read -r a b c d
do
if [[ "$b" == "$search" ]]
then
echo $a,$b,$c,$d
fi
done < contacts.csv
elif [[ "$column" == "mobile" ]]
then
while IFS="," read -r a b c d
do
if [[ "$c" == "$search" ]]
then
echo $a,$b,$c,$d
fi
done < contacts.csv
else
while IFS="," read -r a b c d
do
if [[ "$d" == "$search" ]]
then
echo $a,$b,$c,$d
fi
done < contacts.csv
fi
;;

delete)
touch temp.csv
if [[ "$column" == "fname" ]]
then
while IFS="," read -r a b c d
do
if [[ "$a" != "$search" ]]
then
echo "${a},${b},${c},${d}" >> temp.csv
fi
done < contacts.csv
elif [[ "$column" == "lname" ]]
then
while IFS="," read -r a b c d
do
if [[ "$b" != "$search" ]]
then
echo "${a},${b},${c},${d}" >> temp.csv
fi
done < contacts.csv
elif [[ "$column" == "mobile" ]]
then
while IFS="," read -r a b c d
do
if [[ "$c" != "$search" ]]
then
echo "${a},${b},${c},${d}" >> temp.csv
fi
done < contacts.csv
else
while IFS="," read -r a b c d
do
if [[ "$d" != "$search" ]]
then
echo "${a},${b},${c},${d}" >> temp.csv
fi
done < contacts.csv
fi
cat temp.csv > contacts.csv
rm temp.csv
;;

display)
touch temp.csv
cat contacts.csv > temp.csv
if [[ "$ascending" == 1 ]]
then
tail -n+2 temp.csv | sort -k1 -t,
elif [[ "$descending" == 1 ]]
then
tail -n+2 temp.csv | sort -k1 -r -t,
else
tail -n+2 temp.csv
fi
rm temp.csv
;;

edit)
touch temp.csv
while IFS="," read -r a b c d
do
if [[ "$a" == "$ename" ]]
then
echo "${fname},${lname},${mobile},${office}" >> temp.csv
else
echo "${a},${b},${c},${d}" >> temp.csv
fi
done < contacts.csv
cat temp.csv > contacts.csv
rm temp.csv
;;
esac 