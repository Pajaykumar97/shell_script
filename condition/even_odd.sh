#!/bin/bash
# Check if a Number is an Even or Odd.....

echo "Enter the number :"
read num

if [ $num -gt 0 ]; then
    echo "please enter correct number"
    exit 1
fi


if [ $num % 2 == 0 ]; then
    echo "Given number is even"
else 
    echo "given number is odd"
fi
