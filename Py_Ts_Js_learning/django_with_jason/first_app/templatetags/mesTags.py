from django import template 
from django.template.defaultfilters import stringfilter

#comment creer ses propres filtres avec django
register = template.Library()

@register.filter
@stringfilter

def monFiltre (value) :
    return value.upper()