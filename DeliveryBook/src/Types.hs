{-# LANGUAGE TemplateHaskell #-}

module Types where 
-- module contenant l'ensemble des types de mon projet 


import Data.Time
import Data.Aeson.TH
import Data.Aeson
import GHC.Generics


data Calibre  = P | M | G deriving (Read, Show , Eq)
$(deriveJSON defaultOptions ''Calibre)


data PayementBy  = Cash Int | Avance Int deriving (Show,Read,Eq)
$(deriveJSON defaultOptions ''PayementBy)


data Payement = Payement {
    jourPayement :: Day,  -- le jour de payement doit etre dans la semaine correspondante 
    paimentHow :: PayementBy ,
    commande :: String
} deriving (Show,Eq,Read)
$(deriveJSON defaultOptions ''Payement)


data Commande = Commande {
    idCommande :: String,
    nomClient :: String,
    quantite :: Int,
    calibre :: Calibre,
    prixUnitaireAlveole :: Int,
    resteIfAvance :: Int,
    dateCommande :: Day, 
    payement :: Payement,
    commandIsDone :: Bool
    } deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Commande)


-- un client est identifie dans le systeme par son numero de telephone  : c'est un entity
data Client = Client {
    idOfPage :: String,
    nom :: String, 
    telephone :: Int,
    quartier :: String
} deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Client)


-- FactureBamena: type pour materialiser une facture du fournisseur 
data FactureBamena = Bamena {
    transportParCarton :: Int,
    quantites :: Int,
    dateArrivage :: String,
    total :: Int } deriving (Eq, Read, Show)
$(deriveJSON defaultOptions ''FactureBamena)


data Semaine = Semaine {
    numSemaine :: Int,
    debutSemaine :: String,
    finSemaine :: String,
    stockRestant :: Int,
    facture :: FactureBamena,
    transportPourMagasin :: Int
} deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Semaine)


-- un type pour materialiser la page de mon cahier : c'est un entity

data Page = Page {
    idPage :: String,
    semaine :: Semaine,
    listeDeClient :: [Client],
    factureSemaine :: FactureBamena
  } deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Page)

-- un type pour representer mes versements 

data MezzoPagamento = MobileMoney String | Banque String  deriving (Show,Eq,Read)
$(deriveJSON defaultOptions ''MezzoPagamento)


data Versement = Versement {
    sommeVersee :: Int,
    dateVersement :: String,
    versementHow :: MezzoPagamento,
    whichFacture :: FactureBamena
} deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Versement)

