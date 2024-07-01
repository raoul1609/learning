import Control.Monad 
import Control.Monad.Trans.Maybe 
import Control.Monad.Trans.Class 
import Control.Monad.Except
import Control.Monad.Trans
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Writer.Strict

main = do 
  password <- runMaybeT getPassword
  case password of 
    Just p  -> putStrLn "valid password!"
    Nothing -> putStrLn "invalid password!"

isValid :: String -> Bool
isValid = (>= 10) . length

getPassword :: MaybeT IO String 
getPassword = do 
  password <- lift getLine
  guard (isValid password)
  return password 

type MyPasswordError = String

getPassword' :: MaybeT (ExceptT MyPasswordError IO) String 
getPassword'  = do 
  password <- liftIO getLine
  guard (isValid password)
  return password



{-- monads transformers exercices --}

-- ## Exercice1

-- 1

data ProtectedData a = ProtectedData String a

accessData :: String -> ProtectedData a -> Maybe a
accessData s (ProtectedData pass v) =
  if s == pass then Just v else Nothing


type Protected s a = MaybeT (Reader (ProtectedData s)) a

run :: ProtectedData s -> Protected s a -> Maybe a
run protectedData protected = do
  let performedMaybe = runMaybeT protected
  runReader performedMaybe protectedData
   


access :: String -> Protected a a
access inputPassword = do 
  -- acceder au pass contenu dans le reader et comparer avec le pass d'entree
  getProtectedData <- lift ask  
  --MaybeT $ ReaderT $ accessData inputPassword

  let checkAccess = accessData inputPassword getProtectedData
  undefined 
