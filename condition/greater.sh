#!/bin/bash

echo "Enter the number"
read num

if [ $num -ge 100 ]&& [$num -eq 0 ];then
    echo "Given number is greater than"
else
    echo "given number is less that"
fi