from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.shortcuts import render


from .models import Question

#def index (request) :
    #return HttpResponse ("Bienvenu dans l'application polls, ici je vais poursuivre avec la doc officiel de django")

def detail(request, question_id):
    return HttpResponse("You're looking at question %s." % question_id)


def results(request, question_id):
    response = "You're looking at the results of question %s."
    return HttpResponse(response % question_id)


def vote(request, question_id):
    return HttpResponse("You're voting on question %s." % question_id)


'''def index(request):
    latest_question_list = Question.objects.order_by("-pub_date")[:5]
    output = ", ".join([q.question_text for q in latest_question_list])
    return HttpResponse(output)'''


"""def index(request):
    latest_question_list = Question.objects.order_by("-pub_date")[:5]
    template = loader.get_template("polls/index.html")
    context = {
        "latest_question_list": latest_question_list,
    }
    return HttpResponse(template.render(context, request))

# une autre facon que faire les vues, en utilisant la fonction render


def index(request):
    latest_question_list = Question.objects.order_by("-pub_date")[:5]
    context = {"latest_question_list": latest_question_list}
    return render(request, "polls/index.html", context) """

def index(request):
    context = {"message": "appunti template con jason champagne"}
    template = loader.get_template("polls/index.html")
    return HttpResponse (template.render(context, request))