module Infra.FunctionInfra where


import Types 



-- #
-- fonction qui permet de sauvegarder un nouveau client
saveClient :: Client -> IO ()
saveClient = undefined 

-- #
-- prend l'id d'une page, et me ressort tous les client de cette semaine la. ce n'est pas l'id de la bd 
readClientByWeek :: String -> IO [Client]
readClientByWeek = undefined 


-- #
-- fonction pour sauvegarder les commandes
saveCommande :: Commande -> IO Bool
saveCommande = undefined 

-- #
-- fonction pour lire une commande dans la bd
readCommande :: String -> IO [Commande]
readCommande = undefined