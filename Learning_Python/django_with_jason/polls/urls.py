from django.urls import path
from . import views

#l'espace de nom permet d'eviter le conflit lorsque plusieurs application d'un projet ont le meme nom de fichier
app_name = "polls"

urlpatterns = [
    path ('', views.index, name='pollsIndex'),
    path("<int:question_id>/", views.detail, name="detail"),
    # ex: /polls/5/results/
    path("<int:question_id>/results/", views.results, name="results"),
    # ex: /polls/5/vote/
    path("<int:question_id>/vote/", views.vote, name="vote"),
]
