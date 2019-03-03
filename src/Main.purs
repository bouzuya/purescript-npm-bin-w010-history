module Main
  ( main
  ) where

import Data.Array as Array
import Data.Maybe (Maybe)
import Data.Maybe as Maybe
import Effect (Effect)
import Effect.Aff as Aff
import Effect.Class as Class
import Effect.Class.Console as Console
import Effect.Exception as Exception
import Node.Process as Process
import Options as Options
import Prelude (Unit, bind, pure, (<$>))
import Simple.JSON as SimpleJSON
import Stream as Stream

type W010History =
  { mockmockDevNo :: Int
  , mockmockDevUrl :: String
  , note :: String
  , beginThreadUrl :: String
  , endThreadUrl :: String
  , repositoryFullName :: String
  , date010 :: Maybe String
  , date100 :: Maybe String
  }

main :: Effect Unit
main = do
  args <- (Array.drop 2) <$> Process.argv
  options <-
    Maybe.maybe
      (Exception.throw "invalid options")
      pure
      (Options.parse args)
  if options.help
    then Console.log "HELP"
    else Aff.launchAff_ do
      input <- Stream.readString Process.stdin
      json <-
        Class.liftEffect
          (Maybe.maybe
            (Exception.throw "invalid json")
            pure
            (SimpleJSON.readJSON_ input :: _ (Array W010History)))
      Console.logShow json
