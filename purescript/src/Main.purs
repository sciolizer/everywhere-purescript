module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Random
import Data.Int
import Data.Maybe

import Context

main :: forall e. Eff (context :: CONTEXT, random :: RANDOM | e) Unit
main = do
  answer <- randomInt 1 100
  display "I'm thinking of a number between 1 and 100 inclusive. Can you figure it out?"
  onInput (myLineHandler answer)
  return unit

myLineHandler :: forall e. Int -> String -> Eff (context :: CONTEXT | e) Unit
myLineHandler answer s = do
  case fromString s of
    Nothing -> display $ "I don't think that's a number."
    Just x
      | x > answer -> display "Lower"
      | x < answer -> display "Higher"
      | otherwise -> do
        display "Correct!"
