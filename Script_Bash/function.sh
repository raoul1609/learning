#!/bin/bash

test_function() {
    echo "primo passo with the function in bash"
    echo "$1 aura $2 apres deux mois de travail"
}

test_function raoul 110000 # j'appelle ma fonction avec 02 parametres, que je recupere a l'interieur de la fonction avec $1 et $2
# $@ : permet de recuperer tous les parametres d'une fonction, peu importe le nombre
# $FUNCNAME : permet de recuperer le nom de la fonction

echo
echo "function qui prend des parametres, et les affiche"
numberthings() {
    i=1
    for f in "$@"; do
        echo "$i" : "$f"
        ((i++))
    done
    echo "ceci est le resultat de l'appel de la fonction $FUNCNAME"
}

numberthings param1 param2 param3 param4 param5

echo 
echo "function with local variables"
var1="variable 1"
myfunction() {
    var2="variable 2"
    local var3="variable 3" # apres execution de la fonction var3 ne sera plus accessible
}

myfunction

echo $var1
echo $var2
echo $var3

echo
echo "read from a file with <, > and >> pour ecrire la sortie dans un fichier"
while read file; do
    echo "i read a line and it says: $file"
done < results.txt