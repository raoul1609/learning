--import Prelude hiding (Right, Left)

module MyMonad where 



import qualified Control.Monad as C
import qualified Control.Applicative as A
import Prelude hiding (fmap, Left, Right)

{--== exercices about monads, cf le livre : Thinking functionally with haskell, de RICHARD BIRD ==--}

-- fonction qui additionne 3 nombres de types Maybe Int : version simple  

add :: Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int 
add Nothing _ _ = Nothing 
add _ Nothing _ = Nothing 
add _ _ Nothing = Nothing 
add (Just x) (Just y) (Just z) = Just (x + y + z)


-- fonction add avec les monads. j'utilise le do-notation. c'est aussi faisable avec le bind >>=
addMonad :: Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int
addMonad x y z = do 
    i <- x 
    j <- y 
    k <- z 
    C.return (i + j + k)



{-== others exercices about monads, cf le livre : haskell programming from first principles ==-}

-- 1 
data Nope a = NopeDotJpg   -- c'est un type constant, non è difficile 

instance Functor Nope where 
    fmap f x = NopeDotJpg
instance Applicative Nope where 
    pure x = NopeDotJpg
    f <*> x = NopeDotJpg
instance Monad Nope where 
    return = A.pure 
    x >>= f = NopeDotJpg

--2
data PhhhbbtttEither b a = Left a | Right b --molto importante: il primo parametro fissato nel costruttore del tipo :: b, non è che le premier parametre doit toujours:: a, dipende della posizione 

instance Functor (PhhhbbtttEither r) where 
    fmap f (Left x) = Left (f x)
    fmap f (Right y) = Right y 

instance Applicative (PhhhbbtttEither e) where -- la fonction ne peut etre contenue que dans le Left car le Right a un parametre deja fixé, y :: PhhhbbtttEither b a quindi c'est mieux d'utiliser 
                                                -- la fmap definie dans l'instance de Functor que d'utiliser le pattern matching 
    pure x = Left x 
    Left f <*> y = fmap f y   -- je ne peux pas me limiter a definir seulement Left, si il y a Left il faut un Right   
    Right x <*> _ = Right x  

instance Monad (PhhhbbtttEither e) where 
    return = MyMonad.pure 
    Right x >>= _ = Right x 
    Left y >>= f = f y  -- f met dans le contexte, donc inutile d'ecrire : Left (f y)

--3
newtype Identity a = Identity a deriving (Eq, Ord, Show)

instance Functor Identity where
fmap f x = Identity (f x)

instance Applicative Identity where
pure  = Identity 
(<*>) (Identity f) (Identity s) = Identity (f s)

instance Monad Identity where
return = pure
(>>=) (Identity a) f = f a 
    
     
