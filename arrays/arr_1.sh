#!/bin/bash

Movie=("Ajay""Ajju""Ajji")

echo "First movie ${Movie[0]}"
echo "Number of movies passes : ${#Movie[@]}"
echo "Printing all movies ${Movie[*]}"