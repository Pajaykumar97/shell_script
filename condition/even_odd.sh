#!/bin/bash
# Check if a Number is an Even or Odd.....

echo "Enter the number :"
read num

if [ $num / 2 -ne 0 ]; then
    echo "Given number is even"
elif [ $num -ne 0 ]; then
    echo "please enter correct number"
else 
    echo "given number is odd"
fi
