from math import ceil
from random import randrange

# TP : tous au casino 
# fonction pour determiner la couleur d'un nombre

solde = 100
continuer = True 
randomVar = randrange (50)
i = 1

def whatColor (nbre) :
    if nbre % 2 == 0 :
        return "noir"
    else : return "rouge"

def verite (val = True) :
    something = input ("voulez vous continuer la partie ? oui ou non ")
    if something == "oui" : return val
    else : return False

# il faut une variable pour materialiser le solde 

# tant que continuer == True , la partie continue 
while continuer :
    #     # tant de le solde n'est pas negatif, la partie continue
    while solde > 0 :
             # while there are enough money, we ask him to choice a number 
        var =  (input ("choisir un nombre entre 0 et 49 : "))
        #vartoint = int (var)
        try :
            vartoint = int (var)
            assert vartoint > 0 and vartoint < 49
        except ValueError :
            print ("veuillez entrer un nombre entier")
            continue
        except AssertionError : 
            print ("le nombre entre doit etre positif et compris entre 0 et 49") 
            continue  
        i = 1
        #         # we ask him how much to bid
        while i == 1 : 
            inputmoney = input ("combien souhaites-tu miser ?")
        #          # un block try pour capturer les erreurs
            try :
                money = int (inputmoney)  
                assert money <= solde   
            except ValueError  : 
                print ("veuillez saisir des nombres positifs")
                continue
            except AssertionError :
                print ("ta mise ne doit pas depasser ton solde courant qui est {}".format (solde))
                continue    
                # l'argent mise ne doit pas depasser le solde courant 
            if vartoint == randomVar :
                print ("nombre exact: {} ". format (randomVar) )
                print ("bravo, tu as trouve le nombre, tu obtiens : ", (3*money), "$")
                solde = (solde + (3*money))

            elif whatColor (vartoint) == whatColor (randomVar) :
                print ("tu as trouve la couleur, tu recois ", (ceil (money/2)), "$")
                solde = (solde + ceil (money/2))
                    
            else : 
                print ("tu n'as pas trouve le bon numero, ni la bonne couleur, tu as perdu ta mise ")
                solde = solde - money 
            i = 0
        print ("il te reste : {} ".format (solde))
        continuer = verite ()
        if continuer == False :
            solde = - solde
        elif solde > 0 : continue
        else : print ("desole, tu n'as plus rien !, il te reste {}".format(solde))
    continuer = False 
print ("good bye,le casino est toujours ouvert pour toi !!")

        



# test sur la gestion des erreurs 

# someInput = input ("entre une valeur a caster")
# try :
#     toInt = int (someInput)
#     assert toInt > 0
# except ValueError : 
#     print ("impossible de convertir de la variable d'entree")
# except AssertionError :
#     print ("le nombre saisie est inferieur a zero")
# #else :
# # finally :
# #     print ("peut import le resultat du bloc try, continuons")
