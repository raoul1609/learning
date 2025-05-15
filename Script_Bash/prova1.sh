#!/bin/bash 

echo "script qui permet d'affiher les informations sur le systeme"

freespace=$(df -h / | awk 'NR==2 {print$4}')
freemem=$(free -h | awk 'NR==2 {print$4}')

greentext="\033[32n"
bold="\033[1n"
normal="\033[0n"

printf -v logdate "%(%Y-%m-%d)T"

echo "$bold quick system report for $greentext $HOSTNAME$normal"

printf "\tKernel releases: \t%s\n" "$(uname -r)"
printf "\tBash version: \t%s\n" "$BASH_VERSION"
printf "\tFree space: \t%s\n " "$freespace"
printf "\tFiles in pwd: \t%s\n " "$(ls | wc -l )"
printf "\tFree memory: \t%s\n " "$freemem"
printf "\tGenerated on : \t%s\n " "$logdate"

