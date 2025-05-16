#!/bin/bash

date_heure=$(date "+%Y-%m-%d"_%H-%S-%M)
repertoire_a_archiver=$1


tar -czvf "backup_$date_heure.tar.gz" "$repertoire_a_archiver"

if [[ $? -eq 0 ]]; then 
    echo "votre repertoire $repertoire_a_archiver a ete archive avec success"
    exit 0
else 
    echo "echec lors de l'archivage de $repertoire_a_archiver"
    exit 1
fi

creer_fichier