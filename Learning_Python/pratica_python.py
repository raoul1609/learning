# ce fichier contient des cas pratiques durant la lecture de la doc de python

# implement the function reverse, legendo il livro "apprendre la programmation web avec python"

def myReverse (x):
    tailleListe = len (x)
    for i in range (tailleListe) :
        position = tailleListe - i
        reversedListe = "".insert(i, x[position])
    return reversedListe