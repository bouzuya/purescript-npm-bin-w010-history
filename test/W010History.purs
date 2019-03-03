module Test.W010History
  ( tests
  ) where

import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "W010History" do
  TestUnit.test "TODO" do
    Assert.equal 1 1
