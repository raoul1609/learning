import Control.Monad 
import Control.Monad.Trans.Maybe 
import Control.Monad.Trans.Class 
import Control.Monad.Except
import Control.Monad.Trans
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Writer.Strict
import qualified Control.Monad.Reader as MR



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

-- instance Monad (Protected s) where 
--   return :: a -> Protected s a 
--   return x = 
--     MaybeT $ do f 
--     where f :: ProtectedData s -> a 
--           f (ProtectedData str y) = undefined 
    

run :: ProtectedData s -> Protected s a -> Maybe a
run protectedData protected = do
  let performedMaybe = runMaybeT protected
  runReader performedMaybe protectedData
   
-- Protected a a = MaybeT (Reader (ProtectedData a)) a
-- newtype MaybeT m a = MaybeT { runMaybeT :: m (Maybe a) }

-- definir le bind et le return : TAF
-- property test des lois sur les monades

access :: String -> Protected a a
access inputPassword = do 
  -- acceder au pass contenu dans le reader et comparer avec le pass d'entree
  getProtectedData <- lift ask  
  MaybeT $ do 
    return $ accessData inputPassword getProtectedData
    
    -- return $ f getProtectedData


    --   where f :: ProtectedData a -> Maybe a 
    --         f (ProtectedData str y) = accessData inputPassword (ProtectedData str y)


  -- let checkAccess = accessData inputPassword getProtectedData
  -- return checkAccess
  --undefined 