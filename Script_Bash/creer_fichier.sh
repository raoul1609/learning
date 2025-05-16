#!/bin/bash

creer_fichier() {
    read -p "entre une date: " Date
    read -p "entre un nom de fichier: " name
    local continue=1
    while (($continue==1)); do
        if [ -f "$name-$Date" ]; then 
            echo "le fichier $name-$Date existe deja"
            exit 1
        else 
            touch "$name-$Date.txt"
            ((continue++))
            exit 0
        fi
    done
}

creer_fichier