module Main
  ( main
  ) where

import Data.Array as Array
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff as Aff
import Effect.Class.Console as Console
import Effect.Ref as Ref
import Node.Encoding as Encoding
import Node.Process as Process
import Node.Stream (Readable)
import Node.Stream as Stream
import Options as Options
import Prelude (Unit, append, bind, discard, mempty, pure, (<$>))

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
  case Options.parse args of
    Nothing -> Console.log "invalid option"
    Just options ->
      if options.help
        then Console.log "HELP"
        else Aff.launchAff_ do
          Console.logShow args
          input <- readTextFromStream Process.stdin
          Console.log input
