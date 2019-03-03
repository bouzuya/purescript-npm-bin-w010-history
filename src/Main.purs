module Main
  ( main
  ) where

import Data.Array as Array
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console as Console
import Node.Process as Process
import Options as Options
import Prelude (Unit, bind, (<$>))

main :: Effect Unit
main = do
  args <- (Array.drop 2) <$> Process.argv
  case Options.parse args of
    Nothing -> Console.log "invalid option"
    Just options ->
      if options.help
        then Console.log "HELP"
        else Console.logShow args
