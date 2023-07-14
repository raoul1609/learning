{-# LANGUAGE OverloadedStrings #-}

module Infra.FunctionInfra where

import Database.MySQL.Simple
import Database.MySQL.Simple.QueryResults
import Database.MySQL.Simple.Result 
import Database.MySQL.Base.Types
import Data.ByteString.Char8 
import Types 


-- instance pour qu'un type puisse etre mis dans un requette pour la bd


-- instance de queryResults c'est pour les types qui vont etre parametres de la requette vers la bd
instance QueryResults Client where 
        convertResults [fa,fb,fc,fd, fe, f] [va,vb,vc,vd] = Client a b c d
            where   !a = convert fa va
                    !b = convert fb vb 
                    !c = convert fc vc
                    !d = convert fd vd
        convertResults fs vs = convertError fs vs 4

instance QueryResults Commande where 
        convertResults [fa,fb,fc,fd,fe,ff,fg,fh,fi] [va,vb,vc,vd,ve,vf,vg,vh,vi] = 
                Commande a b c d e f g h i 
            where   !a = convert fa va
                    !b = convert fb vb 
                    !c = convert fc vc
                    !d = convert fd vd
                    !e = convert fe ve 
                    !f = convert ff vf
                    !g = convert fg vg 
                    !h = convert fh vh 
                    !i = convert fi vi
        convertResults fs vs = convertError fs vs 9


instance QueryResults Page where 
        convertResults [fa,fb,fc,fd, fe, f] [va,vb,vc,vd] = Page a b c d
            where   !a = convert fa va
                    !b = convert fb vb 
                    !c = convert fc vc
                    !d = convert fd vd
        convertResults fs vs = convertError fs vs 4


instance Result Calibre 

instance Result PayementBy where 
        convert f Nothing = error "erreur de conversion sur le type PayementBy"
        convert f (Just something) = 
                let toString = unpack something
                in case toString of 
                        rightString -> read rightString :: PayementBy
                        _ -> error "impossible de convertir en PayementBy car chaine de charactere vide !" 


instance Result Semaine where 
        convert f Nothing = error "erreur de conversion sur le type Semaine"
        convert f (Just something1) = 
                let toString1 = unpack something1
                in case toString1 of 
                        rightString1 -> read rightString1 :: Semaine
                        _ -> error "impossible de convertire en Semaine car chaine de charactere vide !"


instance Result FactureBamena where 
        convert f Nothing = error "erreur de conversion sur le type FactureBamena"
        convert f (Just something2) = 
                let toString2 = unpack something2
                in case toString2 of 
                        rightString2 -> read rightString2 :: FactureBamena
                        _ -> error "impossible de convertir en FactureBamena car chaine de charactere vide !" 


instance Result Payement where 
        convert f Nothing = error "erreur de conversion sur le type Payement"
        convert f (Just something3) = 
                let toString3 = unpack something3
                in case toString3 of 
                        rightString3 -> read rightString3 :: Payement
                        _ -> error "impossible de car chaine de charactere vide !" 


instance Result [Client] where 
        convert f Nothing = error "erreur de conversion sur le type PayementBy"
        convert f (Just something4) = 
                let toString4 = unpack something4
                in case toString4 of 
                        rightString4 -> read rightString4 :: [Client]
                        _ -> error "impossible de car chaine de charactere vide !" 



instance QueryResults Payement  where 
        convertResults [fa,fb,fc] [va,vb,vc] = Payement a b c 
            where   !a = convert fa va
                    !b = convert fb vb 
                    !c = convert fc vc
        convertResults fs vs = convertError fs vs 3







{- je dois avoir une bd avec plusieurs tables : payement , commande , client -}

-- #
-- fonction qui permet de sauvegarder un nouveau client
saveClient :: Client -> IO ()
saveClient = undefined 


-- #
--fonction pour avoir la liste des commandes d'un client 

allCommands :: String -> IO [Commande]
allCommands = undefined

-- #
-- fonction pour avoir un client en passant son en parametre 

readClient :: String -> IO Client
readClient = undefined


readPage :: String -> IO Page
readPage = undefined


-- #
-- prend l'id d'une page, et me ressort tous les clients de cette semaine la. ce n'est pas l'id de la bd
-- fonctionnalite1 : me donner liste des clients par semaine  
readClientByPage :: String -> IO [Client]
readClientByPage = undefined 


-- #
-- fonction pour sauvegarder les commandes dans la bd
saveCommande :: Commande -> IO Bool
saveCommande = undefined 

-- #
-- fonction pour lire une commande dans la bd
readCommande :: String -> IO [Commande]
readCommande = undefined

-- #
-- fonction qui ressort la liste des clients d'une semaine : qui prend Idpage -> [Client]
listClientByWeek :: String -> IO [Client]
listClientByWeek = undefined

-- # 
-- fonction pour obtenir tous les payements d'une commande 
allPayement :: String -> IO [Payement]
allPayement = undefined 

-- fonction qui enregistre le payement d'une commande 

savePayement :: Payement -> IO ()
savePayement = undefined 

-- fonction qui me sort tous les payements dans la table payement de la bd

listOfAllPayement :: IO [Payement]
listOfAllPayement = undefined

-- fonction pour enregistrer les factures de bamena de chaque semaine 

saveFactureBamena :: FactureBamena -> IO ()
saveFactureBamena = undefined

-- facture pour lire les factures de bamena dans la bd

readFactureBamena :: IO [FactureBamena]
readFactureBamena = undefined