#!/bin/bash
echo "Enter the day :"
read day

if [ $day != "sunday" ];then
    echo "you need to go to school"
else
    echo "today is holliday"
fi