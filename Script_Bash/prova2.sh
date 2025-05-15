echo "bienvenu dans la calculatrice du bash: voici la liste des operations que nous supportons: "

addition() {
    read -p "fisrt number: " nbre1; read -p "second number: " nbre2; echo "la somme donne: $(($nbre1 + $nbre2))"
}

multiplication() {
    read -p "first number: " nbre1; read -p "second number: " nbre2; echo "le produit donne: $(($nbre1 * $nbre2))"
}

soustraction() {
    echo "NB: je soustrait le plus petit du plus grand"
    read -p "first number: " nbre1; read -p "second number: " nbre2;
    if [[ $nbre1 -lt $nbre2 ]] then
        echo "la soustraction donne: $(($nbre2-$nbre1))"
    else 
        echo "la soustraction donne: $(($nbre1-$nbre2))"
    fi
}

i=1
declare -i continuer=1
declare -a operations=("Addition" "Soustraction" "Multiplication")

while (($continuer==1)); do 
    for elem in ${operations[@]}; do
        echo "$i": $elem
        ((i++))
    done
    read -p "entre le numero le l'operation que vous souhaitez executer:" nbre 

    case $nbre in 
        1) echo "vous avez choisi l'addition"; addition;;
        2) echo "vous avez choisi la soustraction";soustraction;;
        3) echo "vous avez choisi la multiplication"; multiplication;;
        *) echo "Veuillez choisir un numero qui est dans le menu."
    esac

    read -p "souhaiter continuer? yes/no: " value
    if [[ $value == "no" ]] then
        ((continuer ++))
        echo "merci de nous faire confiance, nous sommes a votre service."
    fi
done 