#!/bin/bash

# le script s'appellera avec -u username -p password, peu importe l'ordre de passage des options.
while getopts u:p: option
do 
    case $option in 
        u) user=$OPTARG;;
        p) pass=$OPTARG;;
    esac
done 

echo "username: $user and password: $pass"
