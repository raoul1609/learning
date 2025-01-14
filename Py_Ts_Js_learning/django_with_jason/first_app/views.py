from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from .models import Person

def index (request) :
    return HttpResponse ("bienvenu dans notre first app")

# recuperer les donnees dans une table de la bd ?
# django connait deja que les templates se trouvent dans le dossier template
# donc dans chaque app creer, il faut creer un dossier template ou seront stockes les templates

def allInfos (request):
    context = {"persons": Person.objects.all()}
    return render (request, "person.html" , context)
    #return HttpResponse ("retourne toutes les personnes dans la base de donnees")

    #<!--<li><a href= "{% url 'firstApp:show' person.id %}">{{ person.name}}</li>-->


def showOnePerson (request, person_id):
    context = {"onePerson": get_object_or_404 (Person, pk = person_id)}
    return render (request, "showOnePerson.html", context)