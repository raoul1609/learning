{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
import Control.Monad 
import Control.Monad.Trans.Maybe 
import Control.Monad.Trans.Class 
import Control.Monad.Except
import Control.Monad.Trans
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Writer.Strict
import qualified Control.Monad.Reader as MR
import Control.Monad.Identity (Identity(runIdentity))
import Data.Time.Clock.POSIX



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

--                                   ## Exercice1

-- #1

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
  getProtectedData <- lift ask  
  MaybeT $ do 
    return $ accessData inputPassword getProtectedData



-- #2 

type Protected' s a = MaybeT (ReaderT (ProtectedData s) IO) a


run' :: ProtectedData s -> Protected' s a -> IO (Maybe a)
run' var1 var2 = do 
  let performedMaybeT = runMaybeT var2
  runReaderT performedMaybeT var1
   

access' :: Protected' a a
access' = do
  getDataProtected <- lift ask 
  getThePassword <- liftIO getLine 
  -- l'ecriture ci-dessus est le raccourcis de celle-ci : getThePassword <- lift $ lift  getLine
  MaybeT $ do 
    return $ accessData getThePassword getDataProtected



--                                       ## Exercice 2

data Item = Msg String | Section String [Item]
  deriving (Show,Eq)

type Log = [Item]

type Logging a = Writer Log a  -- ceci correspond a : Writer Log a = WriterT Log Identity a 

-- type Writer w = WriterT w Identity
-- newtype WriterT w (m :: Type -> Type) a = WriterT (m (a, w))



--1 

-- ‘log s‘ logs the messages ‘s‘
log :: Show t => t -> Logging ()       -- Logging () = Writer Log () = WriterT Log Identity ()
log x = WriterT $ do 
  return ((), [Msg $ show x])  


-- ‘with_section s m‘ executes m and add its log in a section titled ‘s‘
with_section :: String -> Logging a -> Logging a
with_section str logging = do
  (something, log) <- lift $ runWriterT logging 
  WriterT $ return (something, map (f str) log)
    where f :: String -> Item -> Item
          f inputStr (Msg msg) = Msg $ mappend inputStr msg 
          f inputStr (Section var items) = Section (mappend inputStr var) items


runLogging :: Logging a -> (a, Log)
runLogging  logging = do -- suis dans le contexte de la monade Identity
  let x = runWriterT logging
  runIdentity x 


--2


-- Extend the Logging monad to be able to call IO actions

type ExtendedLogging a = WriterT Log IO a 

-- non on n'a pas besoin de changer le type runLogging
runLoggingChanged :: ExtendedLogging a -> (a, Log)
runLoggingChanged = undefined 

-- Extend Item, log and with_section to always register timestamps

data ExtendedItem = MsgAndTime (String, POSIXTime) | SectionAndTime (String, POSIXTime) [Item]
  deriving (Show,Eq)



extendedLog :: Show t => t -> ExtendedLogging ()
extendedLog var = WriterT $ do 
  return ((), [Msg $ show var])

-- In the case of with_section, you should register two timestamps: one before and one after

-- chaque message est enregistré a un temps donné : (String, POSIXTime)
-- le message de sortie de extendWith_action est associé au temps courant 

type ExtendedLog = [ExtendedItem]

type ExtendedLogging' a = WriterT ExtendedLog IO a

extendedWith_section :: (String, POSIXTime) -> ExtendedLogging' a -> ExtendedLogging' a
extendedWith_section inputMsgWithTime extendedLogging = do 
  (something, somelog) <- liftIO $ runWriterT extendedLogging 
  getTheTime <- liftIO getPOSIXTime
  WriterT $ do 
    return (something, map (g inputMsgWithTime getTheTime) somelog)

      where g :: (String, POSIXTime) -> POSIXTime -> ExtendedItem -> ExtendedItem
            g (str, _) time (MsgAndTime (msg,_)) = MsgAndTime (mappend str msg, time) 
            g (str, _) time (SectionAndTime (msg, _) items) = SectionAndTime (mappend str msg, time) items

