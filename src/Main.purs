module Main
  ( main
  ) where

import Data.Array as Array
import Data.Maybe (Maybe(..))
import Data.Maybe as Maybe
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff as Aff
import Effect.Class as Class
import Effect.Class.Console as Console
import Effect.Exception as Exception
import Effect.Ref as Ref
import Node.Encoding as Encoding
import Node.Process as Process
import Node.Stream (Readable)
import Node.Stream as Stream
import Options as Options
import Prelude (Unit, append, bind, discard, mempty, pure, (<$>))
import Simple.JSON as SimpleJSON

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

readTextFromStream :: Readable () -> Aff String
readTextFromStream r = Aff.makeAff \callback -> do
  ref <- Ref.new mempty
  Stream.onDataString r Encoding.UTF8 \s -> do
    buffer <- Ref.read ref
    Ref.write (append buffer s) ref
  Stream.onEnd r do
    buffer <- Ref.read ref
    callback (pure buffer)
  pure mempty -- canceler

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
      input <- readTextFromStream Process.stdin
      json <-
        Class.liftEffect
          (Maybe.maybe
            (Exception.throw "invalid json")
            pure
            (SimpleJSON.readJSON_ input :: _ (Array W010History)))
      Console.logShow json
