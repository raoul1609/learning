--import Prelude hiding (Right, Left)
{-# OPTIONS_GHC -Wno-missing-methods #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module MyMonad where 



import qualified Control.Monad as C    -- a quanto pare : l'import qualifie est differente de l'import simple 
import Control.Monad
-- import qualified Control.Applicative as A
-- import Prelude hiding (fmap, Left, Right)   -- j'importe le prelude sans les fmap, left et right, si non il y aura confusion avec ceux definis dans ce module  

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
    return (i + j + k)



{-== others exercices about monads, cf le livre : haskell programming from first principles ==-}

-- 1 
data Nope a = NopeDotJpg   -- c'est un type constant, non è difficile 

instance Functor Nope where 
    fmap f x = NopeDotJpg
instance Applicative Nope where 
    pure x = NopeDotJpg
    f <*> x = NopeDotJpg

instance Monad Nope where 
    return = pure 
    x >>= f = NopeDotJpg

--2
-- data PhhhbbtttEither b a = Left a | Right b --molto importante: il primo parametro fissato nel costruttore del tipo :: b, non è che le premier parametre doit toujours:: a, dipende della posizione 

-- instance Functor (PhhhbbtttEither r) where k
--     fmap f (Left x) = Left (f x)
--     fmap f (Right y) = Right y 

-- instance Applicative (PhhhbbtttEither e) where -- la fonction ne peut etre contenue que dans le Left car le Right a un parametre deja fixé, y :: PhhhbbtttEither b a quindi c'est mieux d'utiliser 
--                                                 -- la fmap definie dans l'instance de Functor que d'utiliser le pattern matching 
--     pure x = Left x 
--     Left f <*> Left x  = Left (f x)
--     Left f <*> Right y = Right y     
--     Right x <*> _ = Right x     -- je ne peux pas me limiter a definir seulement Left, si il y a Left il faut un Right

-- instance Monad (PhhhbbtttEither e) where 
--     return = pure 
--     Right x >>= _ = Right x 
--     Left y >>= f = f y  -- f met dans le contexte, donc inutile d'ecrire : Left (f y)

--3
newtype Identity a = Identity a deriving (Eq, Ord, Show)

instance Functor Identity where
    fmap f (Identity x) = Identity (f x)

instance Applicative Identity where
    pure  = Identity 
    (<*>) (Identity f) (Identity s) = Identity (f s)

instance Monad Identity where
    return :: a -> Identity a
    return = pure
    (>>=) (Identity a) f = f a 

--4 
data List a = Nil | Cons a (List a)

instance Functor List where 
     fmap :: (a -> b) -> List a -> List b
     fmap f Nil = Nil 
     fmap f (Cons a x) = Cons (f a)(fmap f x )

instance Applicative List where 
     pure x = Cons x Nil 
     Nil <*> _ = Nil 
     _ <*> Nil = Nil 
     Cons f g <*> Cons x y = Cons (f x) (g <*> y)

instance Monad List where
    return = pure 
    -- Nil >>= f = Nil 
    -- Cons x y >>= f = f =<< Cons x y     -- c'est une autre facon de proceder 
    x >>= f = join $ fmap f x



{-== others exercices about Monads ==-}

data Expr a = Var a | Add (Expr a) (Expr a) deriving Show


instance Functor Expr where 
    fmap f (Var x ) = Var (f x)
    fmap f (Add x y) = Add (fmap f x) (fmap f y)

instance Applicative Expr where   
    pure x = Var x 
    Var f <*> Var x = Var (f x)
    --Var f <*> Add x y = Add (fmap f x) (fmap f y)
    Add f g <*> Add k l = Add (Add (f <*> k) (f <*> l)) (Add (g <*> k) (g <*> l)) 
    --Add f g <*> Var p = 