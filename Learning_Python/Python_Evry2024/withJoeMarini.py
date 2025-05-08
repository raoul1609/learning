# data class to represents data objects

from dataclasses import dataclass, field
import random

'''
    avec les data classes on a deux facons de definir les valeurs par defaut : 
        - en ajoutant directement la valeur par defaut devant l'attribut 
        - ou en utilisant la fonction field  avec l'attribut default (statique), 
            ou bien avec l'attribut default_factory (dynamique)

    on peut creer une classe avec des attributs qui ne change pas une fois instancier, 
    avec l'attribut frozen = true du decorateur dataclass
'''

#definition classique des classes : avec init 
class ClassicBook:
    def __init__(self, title, author, price, pages):
        self.title = title 
        self.author = author
        self.price = price 
        self.pages = pages 

def number_func():
    return int(random.randrange(1, 20))

# definition using data classes
@dataclass
class Book :
    title:str = 'Default title'
    author:str = 'Default author'
    pages:int = 0
    price:float = field(default=10.0) # static default value
    number:int = field(default_factory=number_func) # dynamic default value

    # __post_init__ est une methode speciale qui permet d'ajouter un attribut apres execution de __init__
    def __post_init__(self):
        self.description = f"{self.title} by {self.author} pages {self.pages}"


@dataclass(frozen=True)
class ImmutableData :
    attribute1: str = 'default '
    attribute2: int = 1

    def change_attribute(self, newattr1, newattr2):
        self.attribute1 = newattr1
        self.attribute2 = newattr2


immutable_obj = ImmutableData ("content value", 10) # cette passe, car __init__ instancie un obj
immutable_obj.change_attribute("new content value", 20) # cette ligne va generer uen erreur FrozenInstanceError

book1 = Book ('Sous la cendre le feu', 'Eveline Mpoundi Ngolle', 234, 15000.0)
print(book1)
print

book2 = ClassicBook ('Mathematiques Tle C', 'Raoul', 300, 2300.0)
print(book2)

print(book1.description)