

import Data.List
import System.IO

--- creations de mes types et synonymes de types --
type Nom = String
type Prenom = String
type Organisation = String
type AdresseElectronique = String
data User = User {nom:: Nom, prenom:: Prenom, organisation:: Organisation,
                    adresse:: AdresseElectronique}


--- creations des instances de certaines classes de mes types --

instance Eq User where
    (==) u1 u2 = adresse u1 == adresse u2
instance Show User where
    show u = unwords [nom u, prenom u, organisation u, adresse u]
instance Ord User where 
    (<=) user1 user2 = nom user1 <= nom user2 && prenom user1 <= prenom user2

--- creations des fonctions --
        -- fonctions newuser pour definir un nouvel utilisateur --

newuser :: String -> Prenom -> Nom -> Organisation -> AdresseElectronique -> IO ()
newuser str n p o ad = do
    fileContent <- readFile str
    let user = User {nom = n, prenom = p, organisation = o,adresse = ad}
    if show user `elem` lines fileContent then error "UserDuplicatedException"
    else appendFile str (show user ++ "\n")

        -- fonction searchUser qui cherche un utilisateur--

searchUser :: String -> String -> IO ()
searchUser str fileName = do
    userFileContent <- readFile fileName
    let lignes = lines userFileContent
        var = foldl f accInit lignes
            where accInit = []
                  f :: [String] -> String -> [String]
                  f acc x  = let ts = words x
                             in if h ts str  then x : acc
                                else acc
                                   where  h :: [String] -> String -> Bool
                                          h _ [] = False
                                          h [] _ = False
                                          h (y:ys) str
                                                | g str y = True
                                                | otherwise = h ys str
                                          g :: String -> String -> Bool
                                          g x [] =  False
                                          g x y = if null [w | w <- subsequences y , w == x] then False else True 
    putStrLn $ unlines var 


-- fonction listUser qui renvoie les utilisateurs classés dans l'orde alphabetique --

    
    

