module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Main as Main
import Test.Options as Options
import Test.Stream as Stream
import Test.TemplateString as TemplateString
import Test.Unit.Main as TestUnitMain

main :: Effect Unit
main = do
  Main.main
  log "You should add some tests."
  TestUnitMain.runTest do
    Options.tests
    Stream.tests
    TemplateString.tests
