// ceci est un commentaire sur une ligne 
/* ceci est un commentaire sur plusieurs lignes  */
/* pour declarer les variables on utilise : let , var, const 
- var : permet declarer les variables globales et locales
- let : permet de clarer les variables locales, accessibles uniquement dans le bloc dans lequel il est utilisé
- const : permet de definir un variable accessible en lecture seule
- on peut aussi affecter une valeur a une variale sans mot-clé : elle est dite variable globale non decalrée, c'est une mauvaise 
pratique.
    */
console.log(!true);
var a; 
console.log(a + 5); 

var tableau = ["bonjour", "raoul", "haskell", "javascript", "python"]

var voiture = { plusieursVoitures: { a: "Saab", b: "Jeep" }, 7: "Mazda" };

console.log(voiture.plusieursVoitures.b); // Jeep
console.log(voiture[7]); // Mazda


// exemple d'utilisation : object String et literaux de chaines de caracteres 
let something = "2 + 6" ; 
let someObject = new String(something);

console.log(eval(something)) ; // je m'attend a voir 4
console.log(eval(someObject))
// convertir un object String en son equivalent primitif
console.log(eval(someObject.valueOf ())) ;
let test = String (4) ; 



// exemple d'utilisation de BigInt

const grandEntier = 44522166622336655n ;
const anotherGrandEntier = BigInt(44587899665855);
const bigEntierFromStr = BigInt ("447856985545") ;
console.log (5n/2n) ;


// bloc d'instruction et controle de flux 

var d = 4 ; 
{
    const d = "bonjour"
}; 
console.log (d) ;


//getMois ("bonjour") ; 


// declaration des variables 

var a;
console.log("La valeur de a est " + a); // La valeur de a est undefined

console.log("La valeur de b est " + b); // La valeur de b est undefined
var b; // La déclaration de la variable est "remontée" (voir la section ci-après)

console.log("La valeur de x est " + x1); // signale une exception ReferenceError
let x1;
let y;
console.log("La valeur de y est " + y); // La valeur de y est undefined


// exemple sur la portee des variables: la variable est globale, elle est accessible ne dehors du bloc if.

/* Lorsqu'une variable est déclarée avec var en dehors des fonctions, 
   elle est appelée variable globale car elle est disponible pour tout le code contenu dans le document
   
   Lorsqu'une variable est déclarée dans une fonction, elle est appelée variable locale car elle n'est 
   disponible qu'au sein de cette fonction.*/

if (true) {
    var x = 5;
}
console.log(x); // x vaut 5 

// voici un autre utilisation avec let, ici la variable est locale au bloc if .

if (true) {
    let y = 5;
    // la variable y n'est valable que pour le bloc if 
}
console.log(y); // ReferenceError: y is not defined

// remontée ou hoisting des variables : cet exemple illustre les remontees de variables.

/**
 * Exemple 1
 */
var x;
console.log(x === undefined); // donne "true"
x = 3;

/**
 * Exemple 2
 */
var maVar = "ma valeur";

(function () {
  var maVar;
  console.log(maVar); // undefined
  maVar = "valeur locale";
})();  // le nom de la fonction ici est ()


// remontee des fonctions : seules les declarations de fonctions sont remontees comme illustre l'exemple : 

/* Déclaration de fonction */
toto(); // "truc"
function toto() {
  console.log("truc");
}

/* Expression de fonction */
machin(); // erreur TypeError : machin n'est pas une fonction
var machin = function () {
  console.log("titi");
}