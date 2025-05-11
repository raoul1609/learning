#!/bin/bash

n=0            # n peut stocker plusieurs types, durant le programme il peut stocker un str ou un bool
declare -i m=0  # m ne stockera que les entiers, durant tout le script

printf "resultat: %d\n" $((n+1))
printf "resultat: %d\n" $((m+4))

while (($m < 10))
    do
        echo "m: $m"
        ((m++))
done

echo  # dans le terminal, ceci va mettre un espacement.

until ((n==10)); do 
    printf "n: %d\n" $n
    ((n++))
done