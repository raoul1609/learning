
import System.IO
import Data.Char 
import Data.List 

-- premiere partie: implementation des fonctions pour la conference --

-- creation de mes types --
type MontantInscription = Int 
type Nom = String
type LieuDeDeroulement = String 
type JourDebut = String 
type MoisDebut = String          --- JourDebut .. MoisFin ne peuvent pas etre Int car show (0x) = "x", cela va donner l'erreur dans la fonction newconference 
type JourFin = String 
type MoisFin = String 
type Identifiant = String 
type Annee = Int 
type Sponsor = String 
newtype Mois = Mois {getMois :: String } deriving Read 
newtype Jour = Jour {getJour :: String } deriving Read 
data Date = Date {mois :: Mois , jour :: Jour} deriving Read 
data Conference = Conference {nom :: Nom, lieu :: LieuDeDeroulement, annee :: Annee,
                                dateDebut :: Date, dateFin :: Date, 
                                montant :: MontantInscription, identifiant :: Identifiant, sponsor :: [Sponsor] } deriving Read 

-- creations des instances de mes types pour certaines classe de type --
instance Show Mois where 
    show x 
        | length (getMois x) == 2 && elem (getMois x) [show y | y <- [01,02..12]] = getMois x
        | otherwise = error "format de la date invalide" 
 
instance Show Jour where 
    show y 
        | length (getJour y) == 2 && elem (getJour y) [show x | x <- [01,02..31]] = getJour y
        | otherwise = error "format du jour invalide"

instance Show Date   where 
      show w = let date = getMois (mois w) ++ "/" ++ getJour (jour w)
                              in if length date == 5 then date 
                                 else error "format de la date invalide"
                                
instance Show Conference where 
    show c = unwords [ nom c ++ " " ++  lieu c ++ " "  ++ show (annee c) ++ " " ++
                         show (dateDebut c) ++ " "  ++ show (dateFin c) ++ " " ++ 
                         show (montant c) ++ " " ++ identifiant c ++ " " ++ show (sponsor c)]

instance Eq Conference where 
    (==) c1 c2 = nom c1 == nom c2 && annee c1 == annee c2
instance Ord Conference where 
    (<=) c1 c2 = nom c1 <= nom c2 && annee c1 <= annee c2 



--- creation des mes differentes fonctions ----

        -- fonction qui cree une nouvelle conference avec son identifiant et la liste des sponsors--

newConference :: String ->  Nom -> LieuDeDeroulement -> Annee -> (MoisDebut, JourDebut) -> (MoisFin, JourFin) -> MontantInscription -> IO ()
newConference str n l a (md,jd) (mf,jf) s = do 
    -- putStrLn "entre le nom du fichier dans lequel enregistré la conference: "
    -- nomFichier <- getLine 
    fichierLu <- readFile  str  
    let contenu = lines fichierLu
        conf = Conference {nom = n, lieu = l, annee = a, dateDebut = x, dateFin = y, montant = s, identifiant = idConf n a, sponsor = []} 
                                           where x = Date (Mois  md) (Jour  jd)
                                                 y = Date (Mois  mf) (Jour  jf)
    if show conf `elem` contenu then return ()
    else appendFile str  (show conf ++ "\n")

    

         -- fonction qui cree l'identifiant d'une conference existante --

idConf :: Nom -> Annee -> Identifiant 
idConf nom year  = let firstLetterName = map head $ words nom
                   in  map toUpper firstLetterName ++ show year
        
        -- fonction pour ajouter un sponsor a une conference --

addSponsor :: Conference -> Sponsor -> Conference 
addSponsor Conference {nom = n, lieu = l, annee = a, dateDebut= d1, dateFin =d2, montant = m, identifiant= iden, sponsor = xs} sponsor 
    | sponsor `elem` xs = Conference {nom = n, lieu = l, annee = a, dateDebut= d1, dateFin =d2, montant = m, identifiant= iden, sponsor = xs}
    | otherwise = Conference {nom = n, lieu = l, annee = a, dateDebut= d1, dateFin =d2, montant = m, identifiant= iden, sponsor = sponsor:xs}

        -- fonction qui renvoie la liste des sponsors --

listSponsor :: Conference -> [Sponsor]
listSponsor = sponsor -- methode par point free , sponsor :: [Sponsor] c'est un champ du record syntax du type Conference 

        -- fonction qui renvoie une liste ordonée  des conferences --
listConference :: IO()
listConference = do 
    putStrLn "entre le nom d'un fichier contenant des conferences: "
    fichier <- getLine
    contenu <- readFile fichier 
    let sortie = sort $ lines contenu 
    putStrLn "entre le nom d'un fichier dans lequel enregistré les conferences triées: "
    nomFichierTrie <- getLine 
    writeFile nomFichierTrie $ unlines sortie 

        --variante de la fonction listconference qui restreint la liste des conferences entre deux années ---

varianteListConference :: Annee -> Annee -> IO ()
varianteListConference a b = do
    putStrLn "entre le nom d'un fichier contenant des conferences: "
    fichier <- getLine
    contenu <- readFile fichier 
    let sortie = lines contenu 
        between_a_b = [str | str <- sortie, year <- words str, year `elem` [show x | x <- [a..b]]]
    putStrLn "entre le nom d'un fichier dans lequel enregistré les conferences triées: "
    nomFichierTrie <- getLine 
    writeFile nomFichierTrie $ unlines between_a_b



