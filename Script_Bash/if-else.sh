#!/bin/bash

echo "this script do an if/else condition"

echo "what is the root user id ?"
# we consider that the uid of the root is 0
# we will check if the user enter the right id.

read id
 
if [ 0 -eq "$id" ]
then
    echo "you are the root, so you have all the privileges"
else 
    echo "you are not the root."
fi


