module Domain.FunctionDom where 

import Types
import Data.Time
import Infra.FunctionInfra

-- fonction du domain, pour creer une commande
    -- types synonymes propres aau domaine 
type NomDuClient = String 
type Qte = Int 
type PrixUnitAlveole = Int
type DateDeCommande = Day 
type Facture = Int 
type CashDown = Bool
type Avance = Maybe Int 
type Debitto = Maybe Int 
type FactureOk = Maybe Int 
type Date = Day
type IdPage = String 


-- #
-- fonction pour creer une nouvelle commande : il faut verifier si la commande existe deja !!

createCommandeHelper :: NomDuClient -> Qte -> Calibre -> PrixUnitAlveole -> DateDeCommande -> Commande  
createCommandeHelper = Commande


createCommande :: NomDuClient -> Qte -> Calibre -> PrixUnitAlveole  -> IO Commande 
createCommande nomClient qte calibre prix  = do
    -- quand a t-il passe sa commande ?
    jourCommande <- utctDay <$> getCurrentTime
    -- la nouvelle commande
    let newCommande = createCommandeHelper nomClient qte calibre prix jourCommande 
    -- liste des commandes du client 
    listOfCommand <- readCommande nomClient 
    -- la commande existe deja ??
    if newCommande `elem` listOfCommand then fail "la commande existe deja !"
    else do
        -- il faut sauvegarder apres creation
        saveCommande newCommande 
        return newCommande


-- #
-- fonction pour creer un nouveau client : le client n'est enregistre qu'une seule dois sur une page 
createClientHelper :: IdPage -> NomDuClient -> Commande -> Facture -> CashDown -> Debitto -> Avance -> FactureOk -> Date -> Client 
createClientHelper = Client

createClient :: IdPage -> NomDuClient -> Commande -> Facture -> CashDown -> Debitto -> Avance -> FactureOk  -> IO Client
createClient idpage nomClient commande facture cash debitto avance factureOk  = do
    -- quand a t-il passe sa commande ?
    jourCommande <- utctDay <$> getCurrentTime
    -- le client ne doit pas etre sauvegardee plusieurs dois dans une page !!
    let newClient = createClientHelper idpage  nomClient commande facture cash debitto avance factureOk jourCommande
    -- liste des client de la semaine corresspondate a idpage 
    listOfClient <- readClientByWeek idpage 
    if newClient `elem` listOfClient then fail "ce client a deja une commande pour cette semaine"
    else do
        -- il faut sauvegarder apres creation
        saveClient newClient 
        -- le client doit etre ajoute a la page : updatePage
        return newClient 
