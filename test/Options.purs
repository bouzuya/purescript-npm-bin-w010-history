module Test.Options
  ( tests
  ) where

import Prelude

import Options as Options
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Options" do
  TestUnit.test "no args" do
    Assert.equal (pure { help: false }) (Options.parse [])
  TestUnit.test "--help" do
    Assert.equal (pure { help: true }) (Options.parse ["--help"])

