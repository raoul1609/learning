echo "parcourir une ensemble reduit avec for"

for i in 1 2 3 4 5; do
    echo $i 
done
echo 
echo "parcourir un ensemble en precisant les deux bornes"
for j in {100..1}; do 
    echo $j 
done 
echo 
echo "un for typique a ce qu'on voit d'habitude, la \",\" est remplace par \";\" "
for ((m=0; m<10; m++)); do 
    echo "valeur: $m"
done 
echo
echo "parcourir un tableau indexe"
declare -a index_array=("raoul" "gonzalez" "willson")
for elem in ${index_array[@]}; do 
    echo $elem
done 

echo 
echo "parcourir un tableau associatif"
declare -A assoc_array
assoc_array["nom et prenom"]="Neudjieu Raoul"
assoc_array[profession]="Software Engineer"
assoc_array[ecole]="IUT Evry Val d'Essone"

for val in "${!assoc_array[@]}"; do
    echo $val : "${assoc_array[$val]}"
done

echo 
echo "another loops system"
#rappelle $(commande) -> permet d'executer une commande 
for file in $(ls); do
    echo "file founded: $file"
done
echo
echo "j'appelle un autre script dans celui ci"
./sum.sh 

echo
echo "another way to loop with for: * est l'equivalent de ls"
for l in *; do 
    echo "result: $l"
done