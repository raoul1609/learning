# il est possible d'indiquer la position de l'interpreteur python avec le scheban



#difference entre liste et tuple ?
"""
les tuples sont des structures de donnees qui ne changent pas apres leurs definitions
les listes sont des stuctures de donnees qu'on peut changer apres avoir definit
Exp : liste = [1,2,'raoul'], la variable liste pourrait prendre la valeur [1,2,'argent'] a un moment donne dans le programme
 tuple = ('2', 'deux') ne peut pas changer.
"""



"""
la methode replace('chaine a remplacer', 'nouvelle chaine'), remplace  
	chaine a remplacer par nouvelle liste.
"""

def afficheNomsEtAges () :
    age = input ("entre ton age : ")
    nom = input ("entre ton nom : ")
    print("tu t'appelle " + nom +" et tu as " + age + " ans")

#afficheNomsEtAges()

print ("Hello")

# fonction qui calcule addition et soustraction en capturant les erreurs.
# faire attention aux indentations en python

def principal_fonction():
    action = input ("Quelle action voulez-faire ?")
    pass 

def add_division():

    nbre1 = input("Entre le premier nombre: ")
    nbre2 = input("Entre le deuxieme nombre: ")

    try :
        convertNbre1 = int(nbre1)
        convertNbre2 = int(nbre2)
        addition = convertNbre1 + convertNbre2
        division = convertNbre1/convertNbre2
        return (addition, division)
        #print("l'addition des deux nombre donne: {(addition)} et la division donne " + str (division))

    except (TypeError, ValueError) :
        print("Entrer un entier, et reessayer encore.")
        return ()
         
    except (ZeroDivisionError):
        print("Le diviseur doit etre different de 0 ")
        return ()


#resultat = add_division()
#print (resultat)

names = ["Raoul", "Alice", "Charlie", "Charlie"]

for index, name in enumerate (names, start=1): # le start indique juste a quel numero va commencer le classement
    print(index, name)

### ASSIGNATION MULTIPLE ###
a,b = 5,20
print(f'je mange {a} mangues et {b} mandarines') # autre facon d'appliquer la methode .format
print ("je mange {0} mangues et {1} mandarines".format(a,b)) # utilisation de la methode .format

#first, *middle, last = "Raoul"
first, *middle, last = [1,2,3,4,5]

print ("le premier element : ")
print(type(first))

print("le middle")
print (middle)

print("le last element : ")
print(last)


def nombrePremier ():
    x = int (input ("entre un nombre : "))
    if x>1 & x%2 != 0 :
        return True 
    else:
        return False

#print (nombrePremier())

def tableDeMultiplication():
    nbre = int(input("entre un nombre : "))
    resultat = [nbre*x for x in [0,1,2,3,4,5,6,7,8,9]]

    return resultat

#print(tableDeMultiplication())

montant = 59000

def retrait():
    x = (input("entre le montant a retirer : "))
    try:
        amountRetrait = int(x)
        montantRestant = montant - amountRetrait
        print(f"vous avez effectue un retrait de {amountRetrait}, votre nouveau solde est de: {montantRestant}")
    
    except ValueError:
        print("Entre un nombre entier, et reessaye")

retrait()

