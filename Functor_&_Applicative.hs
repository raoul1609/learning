{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}


import GHC.Arr
--import Control.Applicative
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
      Node f fss <*> Node x ys = Node (f x) ([fmap f i | i <- ys] ++ [(<*>) g (Node x ys)| g <- fss])

    --   -- instance Applicative Tree where
    --         pure x = Node x []
    --         Node f tfs <*> tx@(Node x txs) =
    --         Node (f x) (map (f <$>) txs ++ map (<*> tx) tfs)
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

--data D = D (Array Word Word) Int Int

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
instance Functor (Flip K x) where
    fmap f (Flip ( K x)) = Flip (K (f x))

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
data TalkToMe a = Halt | Print String a | Read (String -> a)

instance Functor TalkToMe where 
    fmap :: (a-> b) -> TalkToMe a -> TalkToMe b 
    fmap f Halt = Halt 
    fmap f (Print x y) = Print x (f y)
    fmap f (Read g) = Read (f.g)

--5

--1)
-- type : []

-- pure :: a -> [a]
-- (<*>) :: [a-> b] -> [a] -> [b]

-- --2)
-- -- type IO
-- pure :: a -> IO a
-- (<*>) :: IO (a -> b) -> IO a -> IO b

-- --3)
-- -- type (,) a
-- instance Applicative ((,) a) where 
-- pure :: a -> (a,a) 
-- (<*>) :: (a,a -> b) -> (a,a) -> (a,b)

-- --4)
-- -- type (->) e
-- pure :: a -> (e -> a)
-- (<*>) :: (e -> a -> b) -> (e -> a) -> (e -> b)

-- 6
--1)
data Pair a = Pair a a deriving Show

instance Functor Pair where 
    fmap :: (a->b) -> Pair a -> Pair b
    fmap f (Pair x y) = Pair (f x) (f y) 

instance Applicative Pair where 
    pure x = Pair x x 
    (Pair f g) <*> (Pair x y) = Pair (f x) (g y) 

--2) 
data Two a b = Two a b

instance Functor (Two a) where 
    fmap f (Two x y) = Two x (f y)

instance Applicative (Two Int) where -- il faut specifier l'instance de Applicative a un type contrait sinon erreur
    pure a = Two 0 a
    (Two _ f) <*> (Two _ y) = Two 0 (f y)
    
--3)
data Three a b c = Three a b c

instance Functor (Three v w) where 
    fmap f (Three x y z) = Three x y (f z)

instance Applicative (Three Int Int) where 
    pure t = Three 0 1 t 
    (Three _ _ f) <*> (Three _ _ l) = Three 0 0 (f l) 

--4)
data Three' a b = Three' a b b 

instance Functor (Three' x) where 
    fmap f (Three' x y z) = Three' x (f y) (f z)

instance Applicative (Three' Int) where 
    pure t = Three' 0 t t 
    (Three' x f g) <*> (Three' y v w) = Three' (x+y) (f v) (g w)

--5)
data Four a b c d = Four a b c d 

instance Functor (Four j k l) where 
    fmap f (Four x y z w) = Four x y z (f w)

instance Applicative (Four String String String) where 
    pure t = Four [] [] [] t 
    (Four _ _ _ f) <*> (Four _ _ _ t) = Four [] [] [] (f t)

--6)
data Four' a b = Four' a a a b  -- molto importante per capire questo capitolo

instance Functor (Four' a) where -- le constructeur de donnees du type Four' prend 3 elements de type a et un de type b
    fmap f (Four' x y z l) = Four' x y z (f l) 

instance Applicative (Four' Int) where 
    pure u = Four' 0 1 2 u
    (Four' _ _ _ f) <*> (Four' _ _ _ x) = Four' 1 2 3 (f x)

--7
  --1)

newtype Pairs a b = Pairs (a,b) deriving Show

instance Functor (Pairs x) where 
    fmap f (Pairs (a, x)) = Pairs (a, f x)

instance Applicative (Pairs (Maybe Int)) where 
    pure x = Pairs (Nothing ,x)
    (Pairs (_,f)) <*> (Pairs (_,y)) = Pairs (Nothing , f y)

  --2)
newtype Assoc a b = Assoc { getPairs :: [(a,b)] } 

instance Functor (Assoc x) where 
    fmap f (Assoc []) = Assoc []
    fmap f (Assoc [(x,y)]) = Assoc [(x,f y)]
    fmap f (Assoc xs) = Assoc (map (\(a,x) -> (a, f x)) xs)
    
type Assoc' a b = [(a,b)]

amap :: (b -> c) -> Assoc' a b -> Assoc' a c
amap f ps =  (map (\(a,y) -> (a, f y)) ps)

instance  Applicative (Assoc (Maybe Int)) where 
    pure x = Assoc [(Nothing ,x)] -- une liste contenant un couple 
    (Assoc []) <*> _ = Assoc [] 
    (Assoc [(_, f)]) <*> (Assoc []) = Assoc []
    (Assoc [(a, f)]) <*> (Assoc [(b, x)]) = Assoc [(Nothing  , f x)]
    Assoc fs  <*> Assoc xs = let liste1 = [snd x | x <- fs]
                                 liste2 = [snd y | y <- xs]
                             in Assoc [(fst i, f j) | i <- xs , f <- liste1, j <- liste2]

type AssocMap a b c = [(a,b->c)]

-- pour que (AssocMap a b c) soit une instance de Functor il ne doit pas etre un synonyme de type 

newtype AssocMap' a b c = AssocMap' {getAssoc :: [(a, b -> c)]}

mmap :: (c -> d) -> AssocMap a b c -> AssocMap a b d
mmap f assocmap = [(a, fmap f g ) | (a, g) <- assocmap]

instance Functor (AssocMap' x y) where 
    fmap f x = AssocMap' [(a, fmap f h) | (a, h) <- getAssoc x]

instance Applicative (AssocMap' Int Int ) where 
    pure x = AssocMap' [(0 , \0 -> x)]
    u <*> v = AssocMap' [(0 , f <*> x) | (0,f) <- getAssoc u , (0,x) <- getAssoc v ]