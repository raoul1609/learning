from django import template 
from django.template.defaultfilters import stringfilter

#comment creer ses propres filtres avec django
#chaque filtre commence avec la ligne du decorateur
register = template.Library()

@register.filter
@stringfilter
def monFiltre (value) :
    return value.upper()

# pour appeler le filtre dans le template, j'utilise son nom au lieu du nom de la fonction
@register.filter (name= "le nom de mon autre filtre")
def autreFiltre (value, uneTaille):
    return len (value) == uneTaille