from django.contrib import admin

# Pour indiquer a l'admin que les objects Question ont une interface d'administration
from .models import Question

admin.site.register(Question)