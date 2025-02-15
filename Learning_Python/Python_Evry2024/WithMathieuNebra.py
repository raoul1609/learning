"""
    avec les methodes speciales, on peut creer un objet et definir comment par exemple faire l'addition entre deux instances de notre objet
    on peut dire a l'interpreteur comment on affiche une instance de notre type
    monObjet + someData = monObjet.__add__(someData), la methode __add__() de monObjet
"""

class Lettura :
    """
        classe creer dans le cadre de la lecture du livre de pyhton ecrit edite par le site du zero.
    """
    def __init__(self, nomLecteur, nomLivre, dateDebut):
        print("construction d'un objet de type Lettura")
        self.nomDuLecteur = nomLecteur
        self.nomDulivre = nomLivre
        self.debutDeLaLecture = dateDebut

    # methode speciale appellee lorsqu'on essaie d'acceder a un attribut d'un objet qui n'existe pas
    # une diffrence entre getattribute et getattr ?

    def __getattr__(self, dateFin):
        print(f"l'attribut {dateFin} n'existe pas dans cette classe.")

    # methode speciale appellee losrqu'on veut afficher un objet directement dans l'interpreteur ou bien avec un print.
    def __repr__(self):
        return (f"informations sur le lecteur: \n nom: {self.nomDuLecteur}, \n nom du livre: {self.nomDulivre} \n debut de la lecture: {self.debutDeLaLecture}")
    

"""
    heritage avec mathieu nebra : comment creer mes propres exceptions
    les exceptions personnalisees doivent heritees des exceptions built-in (Exception la plus part du temps, ou BaseExecption)

"""
class MonException(Exception):
    """
        mon exception prend deux choses : 
            - un constructeur
            - une methodes qui affiche le message d'erreur
            NB: mon exception est leve avec la fonction raise
    """
    
    def __init__(self, error_message):
        self.message = error_message

    def __str__(self):
        return self.message
    
"""
    derriere la boucle for : les iterateurs et les generateurs
        - comment creer mes propres iterateurs
"""

class RevStr(str):

    """
        - la classe RevStr n'a pas de constructeur, donc le constructeur de la classe str qui va permettre de creer un objet de la classe RevStr
        - apres avoir cree un objet RevStr, la fonction iter va permettre de creer un iterateur sur cet objet : elle va appeler la methode __iter__ definie dans RevStr
        - apres on va appele la fonction next en lui passant en parametre notre iterateur, elle va nous renvoyer chaque element. En fait elle va appeler la methode 
            __next__ definie dans ItRevStr

    """

    def __iter__(self):
        return ItRevStr(self)

    
class ItRevStr():

    def __init__(self, chaineAParcourir):
        self.chaine = chaineAParcourir  # la chaine a parcourir
        self.position = len(chaineAParcourir)  # on stocke la position 

    def __next__(self):
        if self.position == 0 :
            raise StopIteration
        else:
            self.position -= 1
            return self.chaine[self.position]
    
"""
    c'est quoi les generateurs ?
    exemple creation d'un generateur qui affiche les nombre compris entre deux nombres a et b / a & b exclus.

    pour tester mon generateur : 
        - me placer dans le directory ou se trouve mon fichier WithMathieuNebra
        - appeler l'interpreteur de pyhton : python3
        - faire un from WithMathieuNebra import *
        - creer une variable qui contenir l'execution de mon generateur en utilisant la fonction iter, vu que c'est une fonction : 
            executionGenerateur = iter(generateur(nbre1, nbre2))
        - appeler la fonction next en lui passant executionGenerator
        - a chaque fois qu'on appelle next(executionGenerator), on obtient une valeur comprise entre les deux bornes
    
"""
def generateur(borneInf, borneSup): 
    while borneInf < borneSup : 
        yield borneInf
        borneInf += 1

"""
    generateur qui prend un parametre lors du parcours. le principe est que losrqu'il renvoi une valeur, comme la fonction se met en pause, 
        on peut lui passer un parametre
""" 

def generateurWithParam(borneInf, borneSup):
    while borneInf < borneSup :
        valeur_recue = (yield borneInf)  #parentheses ne pas a omettre
        if valeur_recue is not None :
            borneInf = valeur_recue
        borneInf += 1
        
"""
    un decorateur est une fonction qui prend une fonction en parametres et renvoies une fonction
    - le decorateur modifie le comportement de la fonction passee en parametre
    - meme principe que les fonctions d'ordre superieur en haskell ?
"""

def decorateur(fonction):

    def fonctionARenvoyer():

        """  Fonction que l'on va renvoyer. Il s'agit en fait d'une
            version
            un peu modifiée de notre fonction originellement définie. On se
            contente d'afficher un avertissement avant d'exécuter notre
            fonction
            originellement définie
        """
        return fonction()

    return fonctionARenvoyer

@decorateur
def salut():
    print("salut, premiers pas avec les decorateurs.")



### LES ANNOTATIONS DE TYPE AVEC PYTHON ####
"""
    mypy et pyright annalysent de facon statique le code python
    avec python il est possible de faire du statique, preciser le type des variables, les types de retour des fonctions
    les modules typing et collections.abc sont utiles pour ecrire du python statique
    il est possible de faire des annotations de type avec python, ca se rapproche un peu des principes du fonctionnel,
    itertools et functools offre quelques effets du fonctionnel avec python
    mot Newtype("nom du type", type de donnees de)  permet creer un nouveau type
"""