module Main
  ( main
  ) where

import Data.Array as Array
import Effect (Effect)
import Effect.Class.Console as Console
import Node.Process as Process
import Prelude (Unit, bind, (<$>))

main :: Effect Unit
main = do
  args <- (Array.drop 2) <$> Process.argv
  Console.logShow args
