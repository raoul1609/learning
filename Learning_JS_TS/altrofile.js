
function getMois (nombre) {
    if (typeof (nombre) === "number") {
        switch (nombre) {
            case  1 : 
                console.log("janvier") ;
                break ;
            case  2 :
                console.log("fevrier") ;
                break ;
            case  3 : 
                console.log("mars") ; 
                break ; 
            case  4 : 
                console.log("avril") ;
                break ;
            case  5 : 
                console.log("mai") ;
                break ;
            default : 
                console.log ("le nombre doit etre compris entre 1 et 5") ;
                break;
        }
    } else {
        // en construisant un objet Error je peux avoir access aux proprietes name et message 
        throw (new Error ("le nombre doit etre compris entre 1 et 5")) ;
    }
} 
  
//console.log (getMois ("bonjour")) ;
try {
    console.log (getMois ("bonjour")) ;
} catch (e) {
    // console.error est mieux adapte pour afficher les erreurs que console.log
    console.error (e.name ) ; // undefined 
    console.error (e.message ) ; // undefined  
}