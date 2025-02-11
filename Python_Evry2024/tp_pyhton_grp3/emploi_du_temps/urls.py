from django.urls import path 
from . import views

urlpatterns = [
    path ('', views.index, name='index'),
    path('save/', views.saveProgram, name='saveProgram'),
    path('view/', views.getProgram, name='showProgram'),
    path('confirmation/', views.confirmation, name='confirmation_page' )
]