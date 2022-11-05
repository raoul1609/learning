{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import System.IO
import Data.List



{-===== ici nous creons nos differents types ======-}

data Type = I | E deriving (Show , Eq, Read)
data Client = Client {
    email :: String,
    numero :: String,
    adresse :: String,
    type' :: Type,
    nom :: String
}

instance Show Client where
    show Client {email = a,
          numero = b,
          adresse = c,
          type' = d,
          nom = e} = unwords [a,b,c,show d,e]
instance Eq Client where
    (==) client1 client2 = email client1 == email client2 && numero client1 == numero client2

{-===== notre fonction qui affiche lit un fichier affiche la liste des clients  ======-}

--1
readFileContent :: String -> IO [Client]
readFileContent fichier = do
    contenu <- readFile fichier
    let sortie = map words $ lines contenu
    return (map correspondance sortie)

-- la fonction qui fait correspondre une ligne du fichier a un type Client

correspondance :: [String] -> Client
correspondance (x:y:z:w:xs) = Client {
    email = x,
    numero = y,
    adresse = z,
    type' = read w :: Type,
    nom = f xs}

    where f :: [String] -> String
          f [] = []
          f [x] = x
          f (x:xs) = x ++ " " ++ f xs

--2
displayFileContent :: String-> IO ()
displayFileContent fichier = do
    listeClient <- readFileContent fichier
    let sortie =  nub listeClient
        resultat = map show sortie
        lignes = unlines resultat
    putStrLn lignes


-- fonction qui ne garde que le doublon a jour  --

doublonAjour :: [Client]-> [Client]
doublonAjour [] = []
doublonAjour (x:xs) = if x `elem` xs then doublonAjour xs else x:doublonAjour xs

--3
noRepeat :: String-> IO ()
noRepeat fichier = do
    listeClient <- readFileContent fichier
    let sortie =  doublonAjour listeClient
        resultat = map show sortie
        lignes = unlines resultat
    putStrLn lignes

--4
displayById :: String -> IO ()
displayById str = do
    listeDesClients <- readFileContent "module1.txt"
    let sortie = displayHelperId str listeDesClients
    print sortie

displayHelperId :: String -> [Client] -> [Client]
displayHelperId str [] = []
displayHelperId str (x:xs)
    | email x == str || numero x == str = x : displayHelperId str xs
    | otherwise = displayHelperId str xs

--5
displayByAdress :: String -> IO ()
displayByAdress str = do
    listeDesClients <- readFileContent "module1.txt"
    let sortie = displayHelperAdress str listeDesClients
    print sortie

displayHelperAdress :: String -> [Client] -> [Client]
displayHelperAdress str [] = []
displayHelperAdress str (x:xs)
    | adresse x == str =  x : displayHelperAdress str xs
    | otherwise = displayHelperAdress str xs

--6 
validateRegistration :: Client -> Bool
validateRegistration client
    | testEmail (email client) && testNumPhone (numero client) = True
    | otherwise = False

-- fonction qui verifie la validite d'une email --

testEmail :: String -> Bool
testEmail email
    | head email /= '@' = f email
    | otherwise = False
        where f :: String -> Bool
              f x
                | let ind = elemIndices '@' x
                  in length ind == 1 = g x
                | otherwise = False
                    where g :: String -> Bool
                          g y = let indice = head $ elemIndices '@' y
                                    emailTronc = drop indice y
                                in  let ind1 = elemIndices '.' emailTronc 
                                    in length ind1 == 1 && h '.' emailTronc
                                    where h :: Char -> String -> Bool
                                          h chr (x:y:xs) = chr /= y

-- fonction pour verifier validite numero de telephone --

testNumPhone :: String -> Bool
testNumPhone numero
    | length numero == 9 = f numero
    | otherwise = False
        where f :: String -> Bool
              f (x:y:xs) =  [x,y] `elem` ["69","68","67","66","65"]

--7 
valideContact :: String -> IO ()
valideContact fichier = do 
    listeClients <- readFileContent fichier 
    let sortie = filter validateRegistration  listeClients
        resultat = map show sortie 
    writeFile "contacts.txt" $ unlines resultat
    


