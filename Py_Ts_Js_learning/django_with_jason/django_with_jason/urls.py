from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse

# fonction ecrite pour specifier la ressource accesible a localhost:8000/
# j'ai decide de la mettre ici

def racinePlateforme (request): 
    return HttpResponse("Bienvenu a la racine de notre plateforme, specifier la ressource voulue apres le /")


urlpatterns = [
    path ('', racinePlateforme),
    path('admin/', admin.site.urls),
    path('first_app/', include ('first_app.urls')),
    path('polls/', include('polls.urls')),
]





"""
URL configuration for django_with_jason project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
