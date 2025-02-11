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

afficheNomsEtAges()