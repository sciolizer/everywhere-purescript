{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Concurrent
import Control.Monad
import Data.Aeson
import qualified Data.ByteString as B
import Data.String
import Data.Text
import Scripting.Duktape

main :: IO ()
main = do
  app <- B.readFile "app.js"
  Just dc <- createDuktapeCtx
  f <- forkIO . forever $ do
    l <- getLine
    callDuktape dc Nothing "handler" [String . fromString $ l]
  exposeFnDuktape dc Nothing "disp" display
  evalDuktape dc "var handler; function onIn(h) { handler = h; }"
  evalDuktape dc "var window = { context: { display: disp, onInput: onIn } };"
  evalDuktape dc app
  threadDelay maxBound

display :: Value -> IO Value
display (String v) = do
  putStrLn . unpack $ v
  return Null
display v = print v >> return Null
