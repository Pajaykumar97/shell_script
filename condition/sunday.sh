#!/bin/bash
echo "Enter the day :"
read day

if [ $day -ne "sunday" ];then
    echo "you need to go to school"
else
    echo "today is holliday"