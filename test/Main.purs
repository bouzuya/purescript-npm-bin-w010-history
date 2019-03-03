module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Main as Main
import Test.Options as Options
import Test.Stream as Stream
import Test.Unit.Main as TestUnitMain

main :: Effect Unit
main = do
  Main.main
  log "You should add some tests."
  TestUnitMain.runTest do
    Options.tests
    Stream.tests
