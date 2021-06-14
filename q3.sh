#!/bin/bash
echo >> "$1"
echo "1. Words - start with 's' and is not followed by 'a'"
cat "$1" | grep -o '\bs[^a ,.()?]\w*\|\bs\b' 
echo "2. Words - start with 'w' and is followed by 'h'"
cat "$1" | grep -o "\bwh\w*" 
echo "3. Words - start with 't' and is followed by 'h'"
cat "$1" | grep -o "\bth\w*"
echo "4. Words - start with 'a' and is not followed by 'n'"
cat "$1" | grep -o '\ba[^n ,.()?]\w*\|\ba\b' 
