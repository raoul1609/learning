module Domain.FunctionDom where

import Types
import Data.Time
import Infra.FunctionInfra
import Data.List
import Text.ParserCombinators.Parsec

-- # les types propres du domain 

type NomDuClient = String
type Quartier = String
type Telephone = Int
type IdOfPage = String

type IdCommande = String 
type Qte = Int
type PrixUnitAlveole = Int
type ResteIfAvance = Int
type DateCommande = Day
type JourDePayement = Day
type MoyenDePayement = PayementBy
type NomDeCommandePaye = String 
type CommandePaye = Bool

type Transport = Int
type Quantite = Int
type DateArrivage = String 
type Total = Int



-- #
-- fonction pour creer un nouveau client

createClient :: IdOfPage -> NomDuClient -> Telephone -> Quartier -> Client
createClient = Client


-- #
-- fonction pour creer une nouvelle commande 

createCommande :: IdCommande -> NomDuClient -> Qte -> Calibre -> PrixUnitAlveole -> ResteIfAvance -> DateCommande -> Payement  -> CommandePaye -> Commande
createCommande = Commande


-- #
-- fonction qui cree un nouveau payement 

buildPayment :: JourDePayement -> MoyenDePayement -> NomDeCommandePaye -> Payement 
buildPayment = Payement 


-- # 
-- parseur pour un type calibre 
parserCalibre :: Parser Calibre 
parserCalibre = do
    (char 'P' <|> char 'M' <|> char 'G') >>= (\x -> return $ (read [x] :: Calibre))
    -- linea seguente : altra possibilità
    --(\x -> read [x] :: Calibre) <$> (char 'P' <|> char 'M' <|> char 'G') >>= return 

verifCalibre :: String -> Either ParseError Calibre 
verifCalibre = parse parserCalibre "il n'existe que trois calibres: P , M et G"


-- #
-- parseur pour un type PayementBy Int
parserPayementBy :: Parser PayementBy 
parserPayementBy = do 
    (string "Cash" >> spaces >> many digit >>= (\x -> return $ Cash (read x :: Int))) <|> 
        (string "Avance" >> spaces >> many digit >>= (\y -> return $ Avance (read y :: Int)))

verifPayementBy :: String -> Either ParseError PayementBy
verifPayementBy = parse parserPayementBy "soit tu payes en Cash, soit tu fais una avance !"


-- #
-- fonction pour construire un element de type factureBamena

buildFactureBamena :: Transport -> Quantite -> DateArrivage -> Total -> FactureBamena
buildFactureBamena = Bamena


