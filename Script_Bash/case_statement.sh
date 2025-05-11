#!/bin/bash 

# il faut respecter la syntaxe du case 
animal="elephant"
case $animal in 
    bird) echo "Avian";;
    dog|cat) echo "Canine";;
    *) echo "No match";;
esac