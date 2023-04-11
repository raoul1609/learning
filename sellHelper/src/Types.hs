
module Types where 
-- module contenant l'ensemble des types de mon projet 

-- un client est identifie dans le systeme par son nom : c'est un entity
data Client = Client {
    nom :: String, 
    commande :: Commande, 
    facture :: Int, 
    cashDown :: Bool,
    debitto :: Maybe Int,
    avance :: Maybe Int, 
    factureOK :: Maybe Int,
    dateLivraison :: String } deriving (Show, Eq, Read)

data Commande = Commande {
    nomClient :: String,
    quantite :: Int,
    calibre :: String,
    prixUnitaireAlveole :: Int,
    clientLivre :: Bool,
    avanceLivraison :: Maybe Int,
    livraisonOK :: Maybe Int} deriving (Show, Eq, Read)

data FactureBamena = Bamena {
    totale :: Int,
    transportParCarton :: Int,
    casses :: Int,
    quantites :: Int,
    date :: String
    }