from django.shortcuts import redirect, render, get_object_or_404
from django.http import Http404, HttpResponse
from .models import Programme, MiawTeachers
from datetime import date
from .forms import ProgammeForm

# Create your views here.

def index (request):
    context = {"titre": "Page d'acceuil",
               "membres_du_groupe": {
                   "chef de groupe": "NEUDJIEU RAOUL",
                   "membre1" : "TCHUENTE PIERRETTE",
                   "membre2" : "KEMAJOU SIMEU",
                   "membre3" : "MENDOUGA ARMEL",
                   "membre4" : "AYINA YVES"}
               }
    return render (request, 'index.html', context)


def saveProgram (request):
    if (request.method == 'POST'):
        formulaire = ProgammeForm (request.POST)
        if formulaire.is_valid():
            # recuperer les donnees verifies dans le formulaire
            dateVerified = formulaire.cleaned_data ["jour"]
            nameTeaherVerified = formulaire.cleaned_data['enseignants']
            intituleCours = formulaire.cleaned_data ["cours"]

            #check si il y a deja cours a la date du formulaire
            try:
                checkExistantCourse = get_object_or_404(Programme, pk= dateVerified)
                return HttpResponse ("Il y a deja un cours programme a la date du " + str(dateVerified))
            
            except Http404:
                # faire une requette dans le bd pour recuperer l'enseignant et ses infos
                lookForTeacher = MiawTeachers.objects.get(nom = nameTeaherVerified)
                formToSave = Programme.objects.create (jour = dateVerified, cours= intituleCours, enseignant=nameTeaherVerified, teacherTel= lookForTeacher.telephone )
                return redirect ("confirmation_page")
    else :
        
        formulaire = ProgammeForm()
        context = {"titre": "Definir Programme",
                "debut": date.today(),
                "fin": date.today(),
                "message": "Developpement d'un site web avec pyhton, qui nous affiche l'emploi de temps de la filiere MIAW",
                "formulaire": formulaire}
        return render (request, 'saveNewProgram.html', context)


# fonction affiche les programmes enregistres dans la bd
def getProgram (request):
    allPrograms = Programme.objects.all()
    context = {"allPrograms": allPrograms,
               "titre": "Affichage du programme",
               "message": "Plateforme qui affiche l'emploi du temps de licence professionnelle deloacalisee, filiere MIAW"}
    
    return render (request, 'showProgram.html', context)


def confirmation (request):
    context = {"titre" : "Confirmation"
    }
    return render (request, 'confirmation_page.html', context)


