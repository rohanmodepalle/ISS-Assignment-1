#!/bin/bash
if [ $# == 0 ]
then
find . -type d -print0 | while read -d '' -r dir;
do
number=("$dir"/*)
x="${dir%"${dir##*[!/]}"}"
echo -n "${#number[@]} " >> output.txt
echo -n "$x, " | sed 's/.*\///' >> output.txt
echo ""${#number[@]}" file(s)" >> output.txt
done
sed -i '1d' output.txt
sed '1 s/^//' output.txt > output2.txt
sort -k1 -nr output2.txt > output.txt
awk '{$1=""; print $0}' output.txt > output2.txt
echo "Directories:"
cat output2.txt | sed -e 's/^[ \t]*//'
rm output.txt
rm output2.txt
echo 
echo "Files: "
find . -type f -printf "%s %p\n" | sort -nr | sed 's/.*\///'
else
find . -path "$@" -type d -print0 | while read -d '' -r dir;
do
number=("$dir"/*)
x="${dir%"${dir##*[!/]}"}"
echo -n "${#number[@]} " >> output.txt
echo -n "$x, " | sed 's/.*\///' >> output.txt
echo ""${#number[@]}" file(s)" >> output.txt
done
sed -i '1d' output.txt
sed '1 s/^//' output.txt > output2.txt
sort -k1 -nr output2.txt > output.txt
awk '{$1=""; print $0}' output.txt > output2.txt
echo "Directories:"
cat output2.txt | sed -e 's/^[ \t]*//'
rm output.txt
rm output2.txt
echo 
echo "Files: "
find . -path "$@" -type f -printf "%s %p\n" | sort -nr | sed 's/.*\///'
fi