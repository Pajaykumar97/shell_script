#!/bin/bash

Fruits=("Apple" "Grape" "Orange" "watermelon")
for item in "${Fruits[@]}"; do
echo $item
done
echo "============================="

fruits=("Orange" "green apple" "Guvva")
for item in "${fruits[@]}"; do
echo $item
done
echo "==========================="

vihicle=("car" "bus" "cycle")
for item in "${vihicle[@]}"; do
echo $item
done

echo "========================"

movie=("pushpa" "luckybashkar" "babraba")
for item in "${movie[@]}"; do
echo $item
done