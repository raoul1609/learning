type Stack = [Int]

-- exercices about monads, cf le livre : Thinking functionally with haskell, de RICHARD BIRD --

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

