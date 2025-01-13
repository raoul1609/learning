from django.urls import path
from . import views

urlpatterns = [
    path ('', views.index, name = 'index'),
    path ('persons', views.allInfos, name='persons'),
    path ('persons/<int:person_id>', views.showOnePerson, name='show')
]
