from django.shortcuts import render
from django.http import HttpResponse

def index (request) :
    return HttpResponse ("bienvenu dans notre first app")