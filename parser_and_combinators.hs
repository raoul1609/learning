
--import Text.Regex.Posix
import qualified Text.Parsec as T
import Text.ParserCombinators.Parsec
import  Data.List

type Jour = String
type Mois = String
type Annee = Int
data Date = Date {jour :: Jour, mois :: Mois , annee :: Annee }
type Identifiant = String
data Email = Email {first :: Identifiant , second :: String , end :: String}

type Solde = Int
type Entreprise = String
type ReferenceTransac = String
data Transaction  = T {coutTransaction :: Int , referenceTransaction :: ReferenceTransac}
data Facture = F {numeroFacture :: Int, montantFacture :: Int }
data Paiement = P {soldeCourant :: Solde, infoTransaction :: Transaction, infoFacture :: Facture}

instance Show Paiement where
    show x = "solde courant : " ++ show (soldeCourant x) ++ "\n" ++
                show (infoTransaction x) ++ "\n" ++
                    show (infoFacture x)

instance Show Facture where
    show y = "numero de facture : " ++ show (numeroFacture y) ++ "\n" ++
                "montant facture :" ++ show (montantFacture y)

instance Show Transaction where
    show t = "cout :" ++ show (coutTransaction t) ++ "\n" ++
                "reference :" ++ show  (referenceTransaction t)

instance Show Date where
    show var = "jour : " ++ show (jour var) ++ "\n" ++ "mois :" ++ show (mois var) ++ "\n" ++ "annee: " ++ show (annee var)

instance Show Email where
    show y = if null (first y) then error "identifiant nul"
                else  first y ++ "@" ++ second y ++ "." ++ end y


-- le code du parser d'une date 
parsedate :: Parser Date
parsedate = do
    jour <- many digit
    char '/'
    mois <- many digit
    char '/'
    annee <- many  digit
    let anneeInt = read annee :: Int
        j = if  length jour == 1 then "0" ++ jour else jour
    return $ Date j mois anneeInt

-- fonction utile pour faire le parsing de la date 
findDate :: String -> Either ParseError Date
findDate = parse parsedate "le format de la date ne correspond pas "

-- -- parser d'un email : elieraoulnet@gmail.com

parserEmail :: Parser Email         -- jean94@domain.com
parserEmail = do
      x <- parserIdentifiant
      let y = parse parserPoint "" x
      case y of
        Left _ -> unexpected x
        Right a -> do
            let u = a
            char '@'
            var <- many (noneOf ".")
            let varParser = parse parserDomaine "" var
            case varParser of
                 Left _ -> unexpected var
                 Right b -> do
                    let k = b
                    char '.'
                    z <- many letter <?> "extension non-valide "
                    let email = Email {first = u, second = k, end = z} -- u ++ "@" ++ k ++ "." ++ z 
                    return email
                    -- newline 
                    -- parserEmail

parserIdentifiant :: Parser String
parserIdentifiant  = do
    lookingFor <- many (noneOf "@")
    -- state <- TP.getState
    -- TP.putState state 
    return lookingFor

parserPoint :: Parser String
parserPoint = do
    x <- many (noneOf ".") `sepBy` char '.'
    if "" `elem` x then unexpected "ne doit pas commencer par '.' | contient au moins deux points consecutifs" else return $ intercalate "." x

parserDomaine :: Parser String
parserDomaine = do
    firstChar <- noneOf "-0123456789"
    dopo <- many (noneOf "-") `sepBy` char '-'
    if "" `elem` dopo then unexpected "ne commence pas par un tiret" else return (firstChar : intercalate "-" dopo)

-- fonction qui appelle la fonction du parsing d'un email 
-- parseFromFile permet d'analyser depuis un fichier, il ne retourne pas a la ligne  

fonctionEmail :: IO ()
fonctionEmail = do
    fileContent <- readFile "emailFile.txt"
    let fileLines = lines fileContent
        result = map (parse parserEmail "") fileLines     
    writeFile "email_conformes.txt" (unlines (map f result))
        where f :: Either ParseError Email -> String
              f (Right x) = show x
              f (Left y) = ""


-- test de fonctionnalite avec getInput et setInput  
testParser :: Parser String
testParser = do
    noneOf "@" >> string "debut"
    reste <- getInput   -- getInput recupere le reste de la chaine apres un parsing 
    setInput reste      -- setInput continues l'analyse avec le reste de la chaine 
    string "fin"

fonctionTestParser :: String -> Either ParseError String
fonctionTestParser = parse testParser "erreur survenue : personnalise"


parserRefTransac :: Parser ReferenceTransac
parserRefTransac = do
    x <- count 2 upper <?> "format de la reference invalide"
    -- reste <- getInput 
    -- setInput reste 
    first <- many digit
    char '.'
    second <- many digit
    char '.'
    y <- upper <?> "format de reference invalide"
    end <- many digit
    let result = x ++ first ++ "." ++ second ++ "." ++ (y:end)
    return result

-- fonction pour analyser un element de type ReferenceTransac

refTest :: String -> Either ParseError ReferenceTransac
refTest = parse parserRefTransac "format de reference invalide"

-- parser d'un message recu apres paiement de la facture 

parserMessage :: Parser Paiement
parserMessage = do
    string "Vous venez de regler la totalite de votre facture chez" >> spaces
    entreprise <- many letter
    spaces
    string "d'un montant de" >> spaces
    montant <- many digit
    spaces
    many letter >> char '.' >> newline
    string "Cette transaction vous a coute:" >> spaces
    frais <- many digit
    spaces >> many letter >> newline
    string "Votre nouveau solde est de:" >> spaces
    solde <- many digit
    spaces >> many letter >> newline
    string "Numero de facture:" >> spaces
    numero <- many digit
    newline
    string "Reference de transaction:" >> spaces
    refNum <- parserRefTransac
    newline
    string "Orange Money  vous remercie"
    let transac = T {coutTransaction = read frais :: Int , referenceTransaction = refNum}
        fact = F {numeroFacture = read numero :: Int , montantFacture = read montant :: Int}
        paiement = P {soldeCourant = read solde :: Int, infoTransaction = transac, infoFacture = fact}
    return paiement

-- comment faire pour appeler l'erreur de parserRefTransac dans message fonv

message :: IO ()
message = do
    result <- parseFromFile parserMessage "messages.txt"
    writeFile "informations.txt" (f result)
        where f :: Either ParseError Paiement -> String
              f (Right x) = show x
              f (Left y) = show y
