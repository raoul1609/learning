import uuid
from django.db import models
from datetime import date # importation de date dans le librairie datetime

# Create your models here.
# creation d'un modele de donnees personalise 

class Person(models.Model):
    name = models.CharField (max_length=200, unique= True)
    tel = models.IntegerField(default=0)
    age = models.IntegerField(default=0)
    
    def __str__ (self):
        return self.name


class Etudiant (models.Model) :
    matricule = models.CharField (max_length=200, unique=True)
    name_Etudiant = models.CharField (max_length=200)
    # l'option blank = True dans EmailField permet de laisser le champ vide dans le formulaire
    email = models.EmailField(unique=True, verbose_name= "Adresse e-mail", null=True, help_text="Veuillez entrer un adresse email valide")
    # default donne une date par defaut si user n'inserre aucune date, et c'est la date du jour
    datOfBirth = models.DateField (verbose_name="Date de naissance", null=True, help_text="Fromat : AAAA-MM-JJ", default=date.today )

    #others = models.JSONField (null=True, )


class DeepModel (models.Model):
    id = models.UUIDField (primary_key=True, default=uuid.uuid4, editable=False)
    someData = models.JSONField (default=dict)