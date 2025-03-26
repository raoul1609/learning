#!/bin/bash

echo "nous allons effectuer la somme de deux nombres"

echo "entre le premier nombre: "

read firstnumber 

echo "entre le deuxieme nombre: "

read secondnumber 

((sum=$firstnumber+$secondnumber))

echo "la somme est de: $sum"
