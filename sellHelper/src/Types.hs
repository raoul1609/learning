{-# LANGUAGE TemplateHaskell #-}

module Types where 
-- module contenant l'ensemble des types de mon projet 


import Data.Time
import Data.Aeson.TH
import Data.Aeson
import GHC.Generics


data Calibre  = P | M | G deriving (Read, Show , Eq)
$(deriveJSON defaultOptions ''Calibre)

data Commande = Commande {
    nomClient :: String,
    quantite :: Int,
    calibre :: Calibre,
    prixUnitaireAlveole :: Int, 
    dateCommande :: Day } deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Commande)


-- un client est identifie dans le systeme par son nom : c'est un entity
data Client = Client {
    idOfPage :: String,
    nom :: String, 
    commande :: Commande, 
    facture :: Int, 
    cashDown :: Bool,
    debitto :: Maybe Int,
    avance :: Maybe Int, 
    factureOK :: Maybe Int,
    date :: Day
} deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Client)


-- FactureBamena: type pour materialiser une facture du fournisseur 
data FactureBamena = Bamena {
    total :: Int,
    transportParCarton :: Int,
    casses :: Int,
    quantites :: Int,
    dateArrivage :: Day} deriving (Eq, Read, Show)
$(deriveJSON defaultOptions ''FactureBamena)

-- un type pour materialiser la page de mon cahier : c'est un entity

data Page = Page {
    idPage :: String,
    dateOfRecap :: Day,
    listeDeClient :: [Client],
    factureSemaine :: FactureBamena } deriving (Show, Eq, Read)
$(deriveJSON defaultOptions ''Page)
