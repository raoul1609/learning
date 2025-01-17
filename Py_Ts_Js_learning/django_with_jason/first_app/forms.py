from django import forms 

# help_text est utile pour afficher les messages
class MyForm(forms.Form):
    username = forms.CharField(label="Nom d'utilisateur", max_length= 250, required=False, help_text="Entrer votre nom d'utilisateur")
    email = forms.EmailField (label= 'E-Mail')
    dateOfBith = forms.DateTimeField(label= "Date de naissance", input_formats=['%d/%m/%Y'])
    password = forms.CharField (label="Mot de passe", widget=forms.PasswordInput)

    biographie = forms.CharField (label="Biograpgie", widget=forms.Textarea)
    publicate = forms.CharField(label="Publier le contenu", widget=forms.CheckboxInput)

    languages = [('c', 'Language C'), ('p', 'Language python'), ('h', 'Lamguage Haskell'), ('js', 'Javascript')]
    language = forms.MultipleChoiceField(label = "Language connus", widget= forms.CheckboxSelectMultiple, choices= languages)

    colors = [('1', "Rouge"), ('2', "Blue"), ('3', "Vert Citron")]
    color = forms.ChoiceField (label="Couleur dominante", widget= forms.RadioSelect, choices= colors)

    countries = [('fr', "France"), ('cmr', "Cameroun"), ('jp', "Japan")]
    country = forms.ChoiceField (label="Pays", choices= countries)
