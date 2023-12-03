
# test sur la definition des fonctions en python 

def someFonction (nbre, value = 10) :
    """ l'appel de la fonction en python se passe dans le code """
    i = 0
    while i < value :
        print (i , "*" , nbre , "=" , i*nbre)
        i += 1

#  exemple d'une fonction lambda dans python 
someVar = lambda y : y * y

# le code qui s'execute si on appelle directement focntion.py
if __name__ == "__main__" :
    print ("c'est un appel direct")
    someFonction (1)
    