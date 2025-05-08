#!/bin/bash

## PARCOURS DES TABLEAUX  AVEC FOR ####

echo "parcours d'un tableau indexe: "

declare -a tableau_indexe
tableau_indexe=('raoul', 'elie')

declare -A tableau_associatif

tableau_associatif[cameroun]='Yaounde'
tableau_associatif[france]='paris'
tableau_associatif[usa]='washingtong'

for item in "${tableau_indexe[@]}";do 
 echo -e "$item";
done 

echo "parcours d'un tableau associatif: "

for pays in "${!tableau_associatif[@]}";do
    echo "capitale de $pays: ${tableau_associatif[$pays]}";
done 


## TESTS AVEC LE BASH ###

##FONCTIONS ##

hello_world() {
echo "bonjour tout le monde"
}

addition() {
read -p "nombre 1: " nbre1; read -p "nombre 2: " nbre2; echo $((nbre1 + nbre2)) 
}

multiplication() {
read -p "entre un nombre: " nbre

for x in {0..10};do
	echo "$nbre * $x = $((nbre*x)) "
done
}

addition
multiplication
