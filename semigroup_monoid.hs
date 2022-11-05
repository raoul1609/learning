{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
import Data.Semigroup



data NonEmpty' a = a:|[a] deriving (Show, Eq, Ord) 

instance Semigroup (NonEmpty' a ) where
    (a:|x) <> (b:|y) = a :|(x ++ (b:y))
    --(a:|x) <> (b:|y) = if a == b then a :|(x ++ y)
                       --else a :|(x ++ (b:y)) 


--1
data List a = Empty | Cons a (List a) deriving (Show, Eq)

instance Semigroup (List a) where 
    Empty <> Empty = Empty
    Empty <> Cons a x = Cons a x
    Cons a x <> Empty = Cons a x
    Cons a x <> Cons b y = Cons a (Cons b (x <> y))

instance Semigroup Integer where 
    (<>) = (+)
instance Monoid Integer where 
    mempty = 0

--2
newtype Any' = Any' {getAny' :: Bool} deriving (Show , Read, Ord, Eq,Bounded)

instance Semigroup Any' where 
   Any' True <> Any' False = Any'{ getAny'= True}
   Any' False <> Any' True = Any' {getAny' = True}
   Any' True <> Any' True = Any' {getAny' = True}
   Any' False <> Any' False = Any' {getAny' = False}

instance Monoid Any' where 
    mempty = Any' {getAny' = True}

--3
newtype All' = All' { getAll' :: Bool } deriving (Eq, Ord,Read, Show, Bounded)

instance Semigroup All' where
    All' x <> All' y = All' (x && y)
instance Monoid All' where
    mempty = All' True 



---- exerciecices sur les semigroup cf haskell programming from first principles page 944 ---

--2
newtype Identity a = Identity a 

instance (Semigroup a) => Semigroup (Identity a) where 
    (Identity x) <> (Identity y) = Identity (x<>y)

instance (Monoid a) => Monoid (Identity a) where 
    mempty = Identity mempty -- le mempty envoye a Identity est mempty a


--3
data Two a b = Two a b 

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where 
    (Two x y) <> (Two v w) = Two (x<>v) (y<>w)

instance (Monoid a, Monoid b) => Monoid (Two a b) where 
    mempty = Two mempty mempty


--4
data Three a b c = Three a b c 

instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where 
    (Three x y z) <> (Three j k l) = Three (x<>j) (y<>k) (z<>l)

instance (Monoid a, Monoid b, Monoid c) => Monoid (Three a b c) where 
    mempty = Three mempty mempty mempty

--6 
newtype BoolConj = BoolConj Bool 

instance Semigroup BoolConj where 
    BoolConj x <> BoolConj y = BoolConj (x&&y)

instance Monoid BoolConj where 
    mempty = BoolConj True 

--8
data Or a b = Fst a | Snd b

instance Semigroup (Or a b) where 
    Fst x <> Fst y = Fst y
    Fst x <> Snd y = Snd y
    Snd x <> _ = Snd x 

instance (Monoid a) => Monoid (Or a b) where                   -- pere nkalla
    mempty = Fst mempty

--9 
newtype Combine a b = Combine {unCombine :: (a->b)}

instance (Semigroup b) => Semigroup (Combine a b) where 
    Combine {unCombine = f} <> Combine {unCombine = g} = Combine {unCombine = f<>g}

instance (Monoid b) => Monoid (Combine a b) where 
    mempty = Combine (\x -> mempty)            -- pere nkalla


--10
newtype Comp a = Comp {unComp :: (a->a)}
   
instance (Semigroup a) => Semigroup (Comp a) where 
    Comp {unComp = f} <> Comp {unComp = g} = Comp {unComp = f <> g}

--11
data Validation a b = Failure a | Success b deriving (Eq, Show)

instance Semigroup a => Semigroup (Validation a b) where
    Failure x <> Failure y = Failure (x<>y)
    Failure x <> Success y = Success y
    Success x <> Failure y = Success x 
    Success x <> Success y = Success x

