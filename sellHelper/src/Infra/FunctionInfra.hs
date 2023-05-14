module Infra.FunctionInfra where


import Types 



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
-- prend l'id d'une page, et me ressort tous les client de cette semaine la. ce n'est pas l'id de la bd
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