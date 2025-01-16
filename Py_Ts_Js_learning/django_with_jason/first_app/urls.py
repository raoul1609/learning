from django.urls import path
from . import views

urlpatterns = [
    path ('', views.index, name = 'firstAppIndex'),
    path ('persons/', views.allInfos, name='persons'),
    path ('persons/<int:person_id>', views.showOnePerson, name='show'),
    path ('addDeepModels/', views.addDeepModels, name='TestInsert'),
    path ('editModels/', views.editModel, name='TestEditModel')
]
