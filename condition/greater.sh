#!/bin/bash

echo "Enter the number"
read num

if [ $num >= 100 && $num == 0 ];then
    echo "Given number is greater than"
else
    echo "given number is less that"
fi