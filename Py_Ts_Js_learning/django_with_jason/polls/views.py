from django.shortcuts import render
from django.http import HttpResponse

def index (request) :
    return HttpResponse ("Bienvenu dans l'application polls, ici je vais poursuivre avec la doc officiel de django")