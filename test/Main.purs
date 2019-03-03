module Test.Main where

import Prelude

import Effect (Effect)
import Test.Options as Options
import Test.Stream as Stream
import Test.TemplateString as TemplateString
import Test.Unit.Main as TestUnitMain
import Test.W010History as W010History

main :: Effect Unit
main = TestUnitMain.runTest do
  Options.tests
  Stream.tests
  TemplateString.tests
  W010History.tests
