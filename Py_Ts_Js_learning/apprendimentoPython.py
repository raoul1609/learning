# voici l'exemple d'un commentaire en python
# apprendimento per quanto riguarda la documentazione officiale di python : molto interresante et rica
# NB : la division simple (/) en pyhton donne toujours un float
# la division entiere : // , le reste de la division entiere : % 
# 3 * 'raoul' : repete la chaine 'raoul' 3 fois
# deux chaines cote a cote sont automatiquement concatenés : 'raoul' 'bonjour' => 'raoulbonjour'.
# les chaines de caracteres sont immuables ou immutables en python, car affecter une nouvelle valeur a un indice d'une chaine produit une erreur.
# je me suis arreté sur le troisieme point, prochaine leture je commence sur :  4.D'autres outils de contrôle de flux



# jeudi, 26 septembre 2024 : reprise avec l'apprentissage de python, lecture de la documentation officielle 
"""
- python a un typage dynamique ce qui implique que une variable peut avoir plusieurs types au cours de l'execution d'un script python

- on peut ecrire la boucle if sans le else 
- on peut ecrire la boucle if avec beaucoup de elif

- la boucle for a son else qui est exécuté une fois que la boucle atteint son itération finale.

- la boucle while a son else aussi, qui est executé après que la condition de la boucle devient fausse.
NB : Dans l’un ou l’autre type de boucle, la elseclause n’est pas exécutée si la boucle a été terminée par un break.

- l'instruction continue : permet de continuer avec l'iteration suivante
- l'instruction pass : ne fait rien, Elle peut être utilisée lorsqu'une instruction est requise syntaxiquement 
    mais que le programme ne nécessite aucune action
le pass peut aussi etre utilisé comme le undefined dans haskell, lorsqu'on est en plein reflexion sur un code 

- l'instruction match permet de comparer la valeur d'une expression à des modèles successifs, 
        donnés sous la forme d'un ou plusieurs blocs case
- dans une instruction il y a le cas terminal : le _ qui agit comme le otherwise de haskell
NB: l'intruction match est similaire au pattern matching dans haskell

- samedi 26/10/2024 reprise de la lecture de la doc de python : les fonctions

on peut transmettre les elements a une fonction de trois facons differentes : 
    - par position seule (dans ce cas l'ordre importe), exp : def pos_only_arg(arg, /):
    - par position ou nommé, exp : def standard_arg(arg):
    - seulement nommé, exp : def kwd_only_arg(*, arg):
    
- si il y a un / dans la definition d'une fonction alors les parametres positionnels uniquement sont placés avant le / 
 Dans le cas contraire il y a pas de parametres positionnels uniquement seuls dans la definition de la fonction
    les parametres qui suivent le / peuvent etre positionels ou nommés ou bien nommés uniquement

- les parametres nommés uniquement sont placés apres le *
- exemple combiné : def combined_example(pos_only, /, standard, *, kwd_only):

on peut definir une fonction en precisant qu'elle va prendre un nombre arbritraire d'arguments, en mettant un * devant
nom representant les arguments.
Avant le nombre variable d’arguments, zéro ou plus arguments normaux peuvent apparaître.

exp : def maFonction (*ArgumentsArbitraires)
    - Tout paramètre placé après le paramètre *arg ne pourra ê tre utilisé que comme argument nommé , pas
comme argument positionnel.

- reprise avec la lecture de la doc de python
je dois relire les modules, regarder les videos sur les modules en python

-> lecture du chapitre 9 de la doc de python, je me suis arrete au point 9.3.4
"""