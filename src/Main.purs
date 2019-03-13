module Main
  ( main
  ) where

import Data.Array as Array
import Data.Maybe as Maybe
import Effect (Effect)
import Effect.Aff as Aff
import Effect.Class as Class
import Effect.Class.Console as Console
import Effect.Exception as Exception
import Node.Process as Process
import Options as Options
import Prelude (Unit, bind, pure, (<$>))
import Stream as Stream
import W010History as W010History

main :: Effect Unit
main = do
  args <- (Array.drop 2) <$> Process.argv
  options <-
    Maybe.maybe
      (Exception.throw "invalid options")
      pure
      (Options.parse args)
  if options.help
    then Console.log Options.help
    else Aff.launchAff_ do
      input <- Stream.readString Process.stdin
      json <-
        Class.liftEffect
          (Maybe.maybe
            (Exception.throw "invalid json")
            pure
            (W010History.parse input))
      Console.log (W010History.format json)
