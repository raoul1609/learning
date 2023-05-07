module App.FunctionApp where


import Types
import Domain.FunctionDom
import Infra.FunctionInfra
import Data.Time
import Control.Monad

 
-- # 
-- fonction pour creer un client 

newClient :: String -> String -> Int -> String -> IO String 
newClient idpage someName tel ktier  = do
    -- la liste de tous les clients sur la page dont l'id est idpage
    listeDesClients <- readClientByPage idpage
    -- cherche le client dont le nom est passe en parametre dans cette liste
    let lookforClient = filter ((\x -> (nom x) == someName)) listeDesClients
    if null lookforClient then do
        -- create a new client by calling the pure fonction of the domain
        let nouveauClient = createClient idpage someName tel ktier
        -- after created client, we save it  
        saveClient nouveauClient
        return "le nouveau client a ete cree avec succes !"
    else return $ "le client dont le nom est : " <> someName <> "existe deja !" 


-- #
{- fonction pour creer une nouvelle commande : 
- on ne peut creer une nouvelle commande quand l'ancienne n'est pas livree 
- on ne cree pas une nouvelle commande quand l'ancienne n'est pas payee, il faut au moins l'avannce sur l'ancienne
- il faut regarder si il y encore suffisament du stock pour permettre al commande-}

newCommande :: String -> String -> Int -> String -> Int -> String -> Bool -> IO String
newCommande nomclient qte calibre prixunit date livre_ou_pas payement = do
    -- la qte doit etre inferieure au stock restant :
        -- je ressors le client dont le nom est passe en parametre
    leclient <- readClient nomclient
        -- je ressors la page où est repertorie le client 
    lapage <- readPage $ idOfPage leclient 
        -- la semaine correspondate de la page et le stock restant de la semaine
    let lasemaine = semaine lapage
        resteDuStock = stockRestant lasemaine
    if (read qte :: Int) > resteDuStock then 
        return $ "desole, rupture de stock, il ne reste que : " <> show resteDuStock <> "alveoles"
    else do 
        -- je regarde si le client a deja une commande precedente
        commandesDuClient <- allCommands nomclient
        if null commandesDuClient then do
        -- je fais un nouvel id de commande 
            let newIdentifiant = nomclient <> "1"
        -- je cree la commande 
                newcommande = createCommande newIdentifiant nomclient qte calibre prixunit date livre_ou_pas payement
        -- apres je sauvegarde et je retourne la nouvelle commande
            saveCommande newcommande >> return "la commande a ete cree!"
        else do 
            let newId = (\xs -> nomclient <> show (length xs + 1)) commandesDuClient 
                newcommande' = createCommande newId name qte calibre prixunit date livre_ou_pas payement
            saveCommande newcommande' >> return "la commande a ete cree "