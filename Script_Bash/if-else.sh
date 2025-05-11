#!/bin/bash

declare -i a=3 

echo "facon standard d'ecrire les conditions avec if/then/else/fi et les []"
if [[ $a -lt 4 ]] 
then 
    echo "$a est plus petit que 4"
else 
    echo "$a est plus grand que 4"
fi 

echo "autre facon d'ecrire une condition avec if/then/else/fi"

if (($a > 4))
then 
    echo "$a more thant 4"
else 
    echo "$a less than 4"
fi


