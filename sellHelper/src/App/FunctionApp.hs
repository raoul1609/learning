module App.FunctionApp where


import Types
import Domain.FunctionDom
import Data.Time
import Control.Monad

 
-- #
-- l'evenement nouveau client cree une commande, un client n'a de sens que lorsqu'il passe une commande 
 -- fonction pour creer un client 
newClient :: String -> String -> Int -> Char -> Bool ->  Int -> Maybe Int -> Maybe Int -> Maybe Int -> IO Client  
newClient  idpage nomDuClient qte calibre cash prixUnitaire avance debitto isOkFacture = do 
    -- je calcule la facture du client : en multipliant la quantite commandee par le prix unitaire 
    let someFacture = qte*prixUnitaire 
    -- creer une nouvelle commande : createCommande work well if la commande do not exist
    newcommande <- createCommande nomDuClient qte (read [calibre] :: Calibre) prixUnitaire 
    -- je cree un nouveau client 
    createClient idpage nomDuClient newcommande someFacture cash debitto avance isOkFacture 
   

 