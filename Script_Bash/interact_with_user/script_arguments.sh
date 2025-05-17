#!/bin/bash 

#affiche tous les arguments passe en parametres a mon script 

for argument in "$@" 
do
    echo $argument 
done 

echo "j'ai recu $# arguments"