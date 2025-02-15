### DEFINITION DE LA CLASSE CLIENT ###

class Client :

    # 1 - Attributs de ma classe 
    CNI = 12345
    Nom = "Neudjieu"
    Prenom = "Raoul"
    Tel = 673314822

    # 2 - definir les methodes d'acces au attributs des classes
    def getCNI (self):
        return self.CNI

    def getName(self):
        return self.Nom

    def getPrenom(self):
        return self.Prenom

    def getTel(self):
        return self.Tel

    # 3 - definir un contructeur qui initialise les attributs de la classe.

    def __init__(self):
        # les attributs de l'objet Client
        self.CNI = 000000
        self.Nom = "Neudjieu"
        self.Prenom = "Raoul"
        self.Tel = 673314822

    # creer une classe afficher les informations du client 
    def afficher(self):
        print ("le client {0} {1} dont le numero de la CNI est {2} a pour numero de telephone {3}".format (self.Nom, self.Prenom, self.CNI, self.Tel))


#### DEFINITION DE LA CLASSE COMPTE #### 

class Compte :
     
    code = 0 # code est l'attribut de la classe Compte

    def __init__(self, client:Client):

        Compte.code +=1   # attribut de la classe qui s'incrememte

        # attribut de l'objet Compte
        self.solde = 0
        self._numeroCompte = 212341231232 # est un attribut qui n'est pas accessible or de la classe Compte, on va creer une propriete pour acceder a cet attribut
        self.proprietaire = client

    ####### ENCAPSULATION AVEC PYTHON : TEST SUR LA NOTION DE PROPRIETE #############
    ##################################

    def _get_numeroCompte(self):
        """ mon accesseur, qui retourne la valeur de l'attribut numeroDeCompte"""
        return self._numeroCompte

    def _set_numeroDeCompte (self, newNumAccount):
        """mutateur, pour changer la valeur de l'attribut numeroDeCompte"""
        self._numeroCompte = newNumAccount

    numeroCompte = property (_get_numeroCompte, _set_numeroDeCompte) # property prend dans l'ordre: un accesseur, ensuite un mutateur, etc...

    ####################################

    def nbreDeCompteCree (cls):
        """ methode de classe, permettant d'afficher le nombre d'object cree"""
        print ("{0} ont ete deja cree".format(Compte.code))

    nbreDeCompteCree = classmethod(nbreDeCompteCree) #classmethod permet de a pyhton de reconnaitre nbreDeCompteCree comme une methode de classe

    def getNumeroDeCompte (self):
        return (self.Numero_Compte, self.Solde)


    def crediter (self, montant):
        return (self.solde + montant)

    def anotherCrediter (self, montant, compte):
        # verifier si le compte a suffisament d'argent 
        soldeCourant = compte.solde 
        if (soldeCourant > montant):
            self.solde += montant # je peux aussi appeler la methode crediter
            compte.solde -= montant # debite le montant du compte passe en parametre
            print ("votre compte a ete credite de {0}".format(montant))
        
        else:
            print ("le solde du compte fournit est insuffisant")

    # methode qui affiche le nombre de comptes cree
    def numberOfcreatedAccount(self):
        print ("{0} ont ete cree.".format (Compte.code))

    # methode qui affiche le resume d'un compte
    def printAccountInfos(self):
        resume = {
            'nom proprietaire' : self.proprietaire.getName(),
            'numero de telephone' : self.proprietaire.getTel(),
            'numero de la cni': self.proprietaire.getCNI(),
            'numero de compte': self.numeroCompte,
            'solde courant' : self.solde
        }
        return resume

raoul = Client()
raoulAccount = Compte(raoul)
print (raoulAccount.printAccountInfos())


######## TESTING AVEC PYHTON : TEST DE MA CLASSE COMPTE ######

# utilisation de unittest pour effectuer les tests unitaires
# on utilise pytest pour effectuer des test sur django
# unittest.main() permet d'executer tous les scenarios de test  definis dans mon fichier
# on ne peut avoir qu'une seule classe qui contient tous les tous scenarios de tests disponibles 
# dans mon cas, unittest.main() ne tient pas compte de la classe TestCompte()

import unittest

def addition(a,b):
    return a + b

def testClassCompte():
    return (Compte(raoul))

class TestAddition(unittest.TestCase):
    def test_addition(self):
        print("run le premier test")
        self.assertEqual (addition(2,5), 7)
        print("run le deuxieme test")
        self.assertEqual (addition(-1, 1), 0)
        print("run le test sur le type de la classe Compte")
        self.assertEqual(type(testClassCompte()), Compte)
        print("run le test du type de la methode crediter")
        #self.assertEqual(type(testClassCompte().crediter), int)


### fonction qui va permettre de tester la classe Compte ###

# NB : cette classe n'est pas prise en compte par unittest.main() !!!!!!
class TestCompte(unittest.TestCase):

    def verifType (self):
        print("run le test de type de la classe compte")
        self.assertEqual(type(testClassCompte()), Compte)
        print("run le test du type de la methode crediter")
        self.assertEqual(type(testClassCompte().crediter), int)
        

#print(type(testClassCompte()))

#### AFFICHAGE VERTICAL: LES OPTIONS DE LA FONCTION print()  ####

liste1 = [1,2,3,4]
for element in liste1 :
    print (element, end="\n")


#### COMBINER DEUX DICTIONNAIRES ######

name1 = {"kelly": 23, "derick":34, "john": 7, "ravi": 45}
name2 = {"ravi": 45, "mpho": 67}

name3 = name1 | name2
name4 = {**name1, **name2}

print ("associer deux dictionnaires avec le |", end ="\n")
print (name3)

print ("associer deux dictionnaires avec le ** ", end ="\n")
print (name4)

## TRAVAILLER AVEC LE CALENDRIER #####
import calendar
month = calendar.month (2022, 4)
print(month)
print(type(month))

### TRAVAILLER AVEC LE TEMPS ###

from datetime import datetime
time_now = datetime.now().strftime("%H:%M:%S")
print(f"the time now is {time_now}")


#### TRIER UNE LISTE AVEC sort() ####
liste2 = [2,5,6,8,1,8,9,11]
liste2.sort(reverse=True)  
""" reverse c'est pour renverser la liste resultante, sort crie les listes pas defaut de facon ascendant
sort ne renvoie pas une nouvelle liste, elle agit sur la liste en question """
print(liste2)

### SWAPPER AVEC PYHTON ####
""" on swappe avec """

from collections import Counter
liste3 = ["peter", "kelly", "peter", "moses"]
count_peter = Counter(liste3).get("peter")
print(count_peter)

### itertools utile pour faire le flatten de deux listes : applatir une liste qui contient d'autres listes ###
var1= [[1,2],[3,4]]
var2 = [x for i in var1 for x in i] # methode la plus importante pour faire le flatten de deux listes

######### RECUPERER L'INDEICE DU PLUS GRAND ELEMENT DE LA LISTE X   ########
x = [12,45,67,89,34,67,13]
max_num = max (enumerate (x, start=0), key= lambda x: x[1])
min_num = min (enumerate (x, start=0), key = lambda x: x[1])

print ("the index of the largest number is", max_num[0])
print ("the index of the smallest number is", min_num[0])


unittest.main()  #l'interpreteur ne ignore toute ligne de code, apres la fonction unittest.main()





    

    

