#!/bin/bash
# Check if a Number is an Even or Odd.....

echo "Enter the number :"
read num



if [ $num / 2 == 0 ]; then
    echo "Given number is even"
elif [ $num -gt 0 ]
    echo "please enter correct value"
else 
    echo "given number is odd"
fi
