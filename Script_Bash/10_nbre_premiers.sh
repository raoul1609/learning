#!/bin/bash

declare -i n=0
echo "10 nombres paires avec la boucle while"
#quand la condition est vraie
while (($n < 10 )); 
    do
        if (($n%2 == 0)); then    
            echo $n
            ((n++))
        fi
done 
