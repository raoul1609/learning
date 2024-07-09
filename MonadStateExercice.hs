module MonadStateExercice where 
import Control.Monad.State (State, MonadState (get, put), runState)


-- ######## Exercice 1 ######### 

type Random a = State Int a

fresh :: Random Int
fresh = do 
    currentState <- get 
    let newState = (6364136223846793005*currentState + 1442695040888963407) `mod` 64
    put newState
    return currentState  


runPRNG :: Random a -> Int -> a
runPRNG someState nbre = 
    let runningStateMonad = runState someState 
        (someValue,newNbre) = runningStateMonad nbre
    in someValue  


-- ######### Exercice 2 ##########
