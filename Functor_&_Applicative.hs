{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# LANGUAGE FlexibleInstances #-}

import GHC.Arr
import Control.Applicative
import Distribution.Simple.Utils (xargs)
import Data.Data ((:~~:)(HRefl))

--1

data Tree a = EmptyTree | Node a [Tree a] deriving Show

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node x []) = Node (f x) []
    fmap f (Node x ys) = Node (f x) (map (fmap f) ys )
    fmap f (Node x (y:ys)) = Node (f x) (fmap f y : map (fmap f ) ys)

instance Applicative Tree where
      pure x = Node x []
      EmptyTree <*> _ = EmptyTree
      _ <*> EmptyTree = EmptyTree
      Node f fss <*> Node x ys = Node (f x) ([(<*>) g y | g <- fss , y<- ys])

--2 

data Bool = False | True
--Bool ne peut pas etre instance de funtor car il a pour sorte * 

data BoolAndSomethingElse a = False' a | True' a deriving Show
-- un functor valide peut etre ecrit pour ce type 

instance Functor BoolAndSomethingElse where
    fmap f (False' x) = False' (f x)
    fmap f (True' y) = True' (f y)

instance Applicative BoolAndSomethingElse where
    pure x = True' x -- je considere que un element par defaut dans le context est True'
    True' f <*> True' x = True' (f x)
    True' f <*> False' x = pure (f x)
    False' g <*> False' x = False' (g x)
    False' g <*> True' x = pure (g x)

data BoolAndMaybeSomethingElse a = Falsish | Truish a deriving Show

instance Functor BoolAndMaybeSomethingElse where
    fmap _ Falsish = Falsish
    fmap f (Truish x ) = Truish (f x)

instance Applicative BoolAndMaybeSomethingElse where
    pure = Truish
    Falsish <*> _ = Falsish
    Truish f <*> Falsish = Falsish
    Truish f <*> Truish x = Truish (f x)

newtype Mu f = InF { outF :: f (Mu f) }

-- Mu f ne peut pas etre instance de functor car il a pour kind : (*->*)->*

data D = D (Array Word Word) Int Int

-- D ne peut pas etre instance de funtor car il a pour sorte *

--3
data Sum a b = First b | Second a
instance Functor (Sum e) where
    fmap f (First a) = First (f a)
    fmap f (Second b) = Second b

-- pour Sum et Company les modifications sont effectuees sur le conatructeur de type
-- les corps des fonctions sont definies dans l'exercice  

data Company a b c = DeepBlue a b | Something c
instance Functor (Company e e') where
    fmap :: (a -> b) -> Company e e' a -> Company e e' b
    fmap f (Something b) = Something (f b)
    fmap _ (DeepBlue a c) = DeepBlue a c


data More b a = L a b a | R b a b deriving (Eq, Show)
instance Functor (More x) where
    fmap f (L a b a') = L (f a) b (f a')
    fmap f (R b a b') = R b (f a) b'

--4 : write the instances Functor of the following datatypes

--1)
data Quant a b = Finance | Desk a | Bloor b

instance Functor (Quant x) where 
    fmap f Finance = Finance 
    fmap f (Desk a) = Desk a 
    fmap f (Bloor b) = Bloor ( f b)

instance Applicative (Quant x) where 
    pure x = Bloor x
    Finance <*> _ = Finance 
    _ <*> Finance = Finance 
    Bloor f <*> Bloor y = Bloor (f y)
    --Bloor _ <*> Desk a = Desk a 
    Desk a <*> _ = Desk a 
    _ <*> Desk a = Desk a

--2)
newtype K a b = K a

instance Functor (K x) where -- (le a de (K a) a pour type a)
    fmap :: (a -> b) -> K x a -> K x b
    fmap f (K y) = K y -- (y :: a) 
 
-- instance Applicative (K x) where 
--      pure y =  K y

--3)
newtype Flip f a b = Flip (f b a) deriving (Eq, Show)
newtype K' a b = K' a
instance Functor (Flip K' x) where
    fmap f (Flip ( K' x)) = Flip (K' (f x))

--4)
data EvilGoateeConst a b = GoatyConst b

instance Functor (EvilGoateeConst a) where 
    fmap f (GoatyConst y) = GoatyConst (f y)

instance Applicative (EvilGoateeConst a) where 
    pure x = GoatyConst x
    GoatyConst f <*> GoatyConst x = GoatyConst (f x)

--5)
data LiftItOut f a = LiftItOut (f a)  -- il faut que la sorte de ce type soit *->*
--newtype HelpLiftItOut a b = HelpLiftItOut a

instance (Functor f ) => Functor (LiftItOut f)  where 
    fmap :: (a -> b) -> LiftItOut f a -> LiftItOut f b
    fmap g (LiftItOut x) = LiftItOut (fmap g x)

--6)
data Parappa f g a = DaWrappa (f a) (g a)

instance (Functor f, Functor g) => Functor (Parappa f g) where 
    fmap r (DaWrappa x y) = DaWrappa (fmap r x) (fmap r y)

--7)
data IgnoreOne f g a b = IgnoringSomething (f a) (g b)

instance (Functor g) => Functor (IgnoreOne f g u) where 
    fmap :: (a->b) -> IgnoreOne f g u a -> IgnoreOne f g u b 
    fmap r (IgnoringSomething x y) = IgnoringSomething x (fmap r y) 

--8)
data Notorious g o a t = Notorious (g o) (g a) (g t)

instance (Functor g) => Functor (Notorious g o u) where 
    fmap :: (a->b) -> Notorious g o u a -> Notorious g o u b
    fmap f (Notorious x y z) = Notorious x y (fmap f z)

--9)
data List a = Nil | Cons a (List a)

instance Functor List  where 
    fmap :: (a->b) -> List a -> List b 
    fmap f Nil = Nil 
    fmap f (Cons x y) = Cons (f x)(fmap f y) 

--10)
data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)

instance Functor GoatLord where 
    fmap :: (a->b) -> GoatLord a -> GoatLord b 
    fmap f NoGoat = NoGoat
    fmap f (OneGoat x) = OneGoat (f x)
    fmap f (MoreGoats x  y  z) = MoreGoats (fmap f x) (fmap f y) (fmap f z)

--11)

