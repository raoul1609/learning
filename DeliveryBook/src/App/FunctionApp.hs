module App.FunctionApp where


import Types
import Domain.FunctionDom
import Infra.FunctionInfra
import Data.Time
import Control.Monad


-- # 
-- fonction pour creer un client 
{- -}

newClient :: String -> String -> Int -> String -> IO String
newClient idpage someName tel ktier  = do
    -- la liste de tous les clients sur la page dont l'id est idpage
    listeDesClients <- readClientByPage idpage
    -- cherche le client dont le nom est passe en parametre dans cette liste
    let lookforClient = filter (\x -> nom x == someName) listeDesClients
    if null lookforClient then do
        -- create a new client by calling the pure fonction of the domain
        let nouveauClient = createClient idpage someName tel ktier
        -- after created client, we save it  
        saveClient nouveauClient >> return "le nouveau client a ete cree avec succes !"
    else return $ "le client dont le nom est : " <> someName <> "existe deja !"


-- #
-- fonction pour creer un payement d'une commande 

newPayement :: String -> String -> String -> IO Payement
newPayement ladate moyendepayement unecommande = do
    -- je verifie le format du moyen de payement
    let checkedPayement = verifPayementBy moyendepayement
    case checkedPayement of
        Left _ -> fail "le format de payement ne correspond pas"
        Right someRightThing -> do
            let somePayement = buildPayment (read ladate :: Day) someRightThing unecommande
            -- je sauvegarde le payement 
            savePayement somePayement >> return somePayement




-- #
{- fonction pour creer une nouvelle commande : 
- on ne peut creer une nouvelle commande quand l'ancienne n'est pas livree 
- on ne cree pas une nouvelle commande quand l'ancienne n'est pas payee, il faut au moins l'avannce sur l'ancienne
- il faut regarder si il y encore suffisament du stock pour permettre la commande
- la date peut bien etre genere par le systeme ou bien l'user peut entrer la date et puis je verifie si c'est
dans l'intervalle de la semaine (fastidioso)
- dans mon cahier je n'enregistre que les commandes deja livrees, plus besoin de savoir ai la commande est livree ou pas 
- je peux passer en parametre le moyen de payement pour m'aider a construire le type Payement
- avant de creer la commande le client doit deja existé !! car j'utilise le client 
-}

newCommande :: String -> Int -> String -> Int -> String -> IO String
newCommande nomclient qte calibre prixunit moyenDePayement  = do
    -- la qte doit etre inferieure au stock restant :
        -- je ressors le client dont le nom est passe en parametre, et si le client n'existe pas ??
        {-si je passe le telephone et le tierka en parametre a newcommande, 
            son appel se fera avec ces infos la meme si le client exite deja-}
    leclient <- readClient nomclient
        -- je ressors la page où est repertorie le client 
    lapage <- readPage $ idOfPage leclient
        -- la semaine correspondante de la page et le stock restant de la semaine
    let lasemaine = semaine lapage
        resteDuStock = stockRestant lasemaine
    if qte > resteDuStock then
        return $ "desole, rupture de stock, il ne reste que : " <> show resteDuStock <> "alveoles"
    else do
        -- je regarde si le client a deja une commande precedente pour generer le nom de la commande
        commandesDuClient <- allCommands nomclient
        if null commandesDuClient then do
            -- si c'est null alors c'est la first cmd du client d'ou l'indice 1
            -- je fais un nouvel id de commande 
            let newIdofCommande = nomclient <> "1"
            -- je verifie le calibre passer en parametre 
                checkedCalibre = verifCalibre calibre
            case checkedCalibre of
                Left _ -> return "erreur sur le calibre, soit c'est P M ou G"
                Right someRightCalibre -> do
                    -- je recupere la date du jour de la commande 
                    someDay <- utctDay <$> getCurrentTime
                    -- je fais le payement de la nouvelle commande 
                    lepaiement <- newPayement (show someDay) moyenDePayement newIdofCommande
                    -- je cree la commande en utilisant son paiement qui existe deja dans le systeme
                    case read moyenDePayement :: PayementBy of
                        Cash _ -> do
                            let newcommande = createCommande newIdofCommande nomclient qte someRightCalibre  prixunit 0 someDay lepaiement True
                                -- apres je sauvegarde et je retourne un message de succes
                            saveCommande newcommande >> return "la commande a ete cree, elle a ete paye entierement"
                        Avance someDinero -> do
                            -- je calcule la facture totale de la commande 
                            let facture = qte*prixunit
                                resteAPayer = facture - someDinero
                                newcommande' = createCommande newIdofCommande nomclient qte someRightCalibre  prixunit resteAPayer someDay lepaiement False
                            saveCommande newcommande' >> return ("la commande a ete cree, et est paye partiellement. Il reste " <> show resteAPayer)
        else do
            -- ce n'est pas encore la premiere commande du client
            let newId = (\xs -> nomclient <> show (length xs + 1)) commandesDuClient
                checkedCalibre' = verifCalibre calibre
            case checkedCalibre' of
                Left _ -> return "erreur sur le calibre"
                Right someRightCalibre' -> do
                    someDay' <- utctDay <$> getCurrentTime
                    lepaiement' <- newPayement (show someDay') moyenDePayement newId
                    case read moyenDePayement :: PayementBy of
                        Cash _ Cash Cash Cash -> do 
                            -- la premiere commande passee est reglee, donc il peut commander encore !
                            let newcommande1 = createCommande newId nomclient qte  someRightCalibre' prixunit 0 someDay' lepaiement' True
                            saveCommande newcommande1 >> return "la commande suivante a ete cree, et est reglee entierement !"
                        Avance someVar -> do
                            -- ne peut pas passer autre commande sans regler l'ancienne dette
                            let facture' = qte*prixunit
                                resteAPayer' = facture' - someVar
                            return $ "desole, vous ne pouvez passer une autre commande sans regler l'ancienne dette qui est de : " <>  show resteAPayer'                          



-- #
-- fonction pour avoir tous les cash-down 

cashDown:: IO Int
cashDown = do
    -- va dans la table des payements et me sort tous les payements 
    tousLesPayements <- listOfAllPayement
    -- je sort tous les payementBy
    let listOfPayementBy = fmap paimentHow tousLesPayements
        result = foldl f 0 listOfPayementBy
    return result
        where f :: Int -> PayementBy -> Int
              f a (Cash x) = a + x
              f a (Avance _) = a

-- #
-- fonction pour avoir tous les debitti
debitti :: IO Int 
debitti = do
     -- va dans la table des payements et me sort tous les payements 
    tousLesPayements' <- listOfAllPayement
    -- je sort tous les payementBy
    let listOfPayementBy' = fmap paimentHow tousLesPayements'
        result' = foldl g 0 listOfPayementBy'
    return result'
        where g :: Int -> PayementBy -> Int
              g b (Cash _) = b
              g b (Avance y) = b + y


-- # fonction pour creer un facture de Bamena 
-- la semaine debute dans le systeme quand les oeufs arrivent !!

newFactureBamena :: Int -> Int -> String -> Int -> IO String
newFactureBamena transport qte dateComing totalAPayer = do
    -- je construis une nouvelle facture en appellant le domaine 
    let newFacture = buildFactureBamena transport qte dateComing totalAPayer
    saveFactureBamena newFacture >> return "ok, la facture a ete enregsitree"
