from django.shortcuts import redirect, render, get_object_or_404
from django.http import HttpResponse
from .models import Person, DeepModel

import uuid
from .forms import MyForm

def index (request) :
    #return HttpResponse ("bienvenu dans notre first app")
    if request.method == 'POST' :
        formulaire = MyForm(request.POST)

        if formulaire.is_valid():
            return redirect ("pollsIndex")
    else:
        formulaire = MyForm()
    context = {"form": formulaire}
    return render (request, 'index.html', context)

# recuperer les donnees dans une table de la bd ?
# django connait deja que les templates se trouvent dans le dossier template
# donc dans chaque app creer, il faut creer un dossier template ou seront stockes les templates

def allInfos (request):
    context = {"persons": Person.objects.all(),
               "message": "balise et filtre avec jason, test de creation de mes propres filtres"}
    return render (request, "person.html" , context)
    #return HttpResponse ("retourne toutes les personnes dans la base de donnees")

    #<!--<li><a href= "{% url 'firstApp:show' person.id %}">{{ person.name}}</li>-->


def showOnePerson (request, person_id):
    context = {"onePerson": get_object_or_404 (Person, pk = person_id)}
    return render (request, "showOnePerson.html", context)


"""
    la fonction redirect est utile pour rediriger vers une autre page
    Importantissimo : une view retourne toujours un httpresponse
    dans ce cas particulier je pouvais ecrire un template pour afficher ma reponse
"""

def addDeepModels (request) :
    generatedUuid = uuid.uuid4()
    myJsonData = {"name": 'Neudjieu Raoul', "filere": 'Miaw', "tel" : 673314822}
    mymodelToInsert = DeepModel.objects.create (id = generatedUuid, someData = myJsonData)
    #return redirect ("firstAppIndex")
    return HttpResponse ("Ok, le modele a ete ajoute avec succes. Verifier votre base de donnees")

def editModel (request):
    modelToEdit = DeepModel.objects.get (id="dcb2b4b5423c492bbd47dbe186473e07")
    # la methode raw() prend la requette sql en parametres
    #modelToEdit = DeepModel.objects.raw ("select * from first_app_deepmodel where id = 'dcb2b4b5423c492bbd47dbe186473e07'")
    modelToEdit.someData["tel"] = 695870967
    modelToEdit.save()
    return HttpResponse ("le modele a ete mis a jour, verifier la base de donnees")

"""
    ceci est une fonction qui permet de supprimer un modele dans la base de donnees
"""
def deleteModel (request):
    modelToDelete = DeepModel.objects.filter(id = "c83fd77a15c341579264b947c14a0809")
    modelToDelete.delete()
    return HttpResponse ("ok, les modeles ont ete supprime avec succes")