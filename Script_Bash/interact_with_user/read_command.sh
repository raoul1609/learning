#!/bin/bash 

echo "what is your name? "
read name 

echo "enter your password: "
read -s pass # pour cacher la saisie du mot de passe.

read -p "what is your favorite animal? " animal 

echo "name: $name , password: $pass , animal: $animal"

#un exemple avec select, qui permet de selectionner parmi des options

echo 
echo "select simple"
select car in "Mercedez" "Toyota" "BMW"
do 
    echo "you have selected $car"
    break # tres important de mettre break, sinon boucle infinie 
done 

echo 
echo "select associe au block case "

select animal in "dog" "cat" "bird" "quit"
do 
    case $animal in 
        bird) echo "the bird fly in the sky";;
        dog) echo "the dog lives whith human";;
        cat) echo "the cat likes milk";;
        quit) break;;
        *) echo "i'm not have this option yet"
    esac 
done