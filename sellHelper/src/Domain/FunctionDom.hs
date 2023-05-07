module Domain.FunctionDom where

import Types
import Data.Time
import Infra.FunctionInfra
import Data.List

-- # les types propres du domain 

type NomDuClient = String
type Quartier = String
type Telephone = Int
type IdOfPage = String

type IdCommande = String 
type Qte = Int
type PrixUnitAlveole = Int
type DateCommande = Day
type CommandeLivre = Bool



-- #
-- fonction pour creer un nouveau client

createClient :: IdOfPage -> NomDuClient -> Telephone -> Quartier -> Client
createClient = Client


-- #
-- fonction pour creer une nouvelle commande 

createCommande :: IdCommande -> NomDuClient -> Qte -> Calibre -> PrixUnitAlveole -> DateCommande -> CommandeLivre -> Payement -> Commande
createCommande = Commande

