-- based on https://github.com/bouzuya/create-b/blob/c36fea382bdd21968fdb005c1eba54f5b2db207a/test/TemplateString.purs
module Test.TemplateString
  ( tests
  ) where

import Data.Tuple (Tuple(..))
import Foreign.Object as Object
import Prelude (discard)
import TemplateString as TemplateString
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "TemplateString" do
  TestUnit.test "template" do
    let
      obj1 =
        Object.fromFoldable
          [ Tuple "foo" "FOO"
          , Tuple "bar" "BAR"
          ]
    Assert.equal
      "FOOBAR"
      (TemplateString.template "{{foo}}{{bar}}" obj1)
    let
      obj2 =
        Object.fromFoldable
          [ Tuple "foo" "{{bar}}"
          , Tuple "bar" "{{foo}}"
          ]
    Assert.equal
      "{{bar}}{{foo}}"
      (TemplateString.template "{{foo}}{{bar}}" obj2)
    let
      obj3 =
        Object.fromFoldable
          [ Tuple "foo-bar" "FOO-BAR"
          , Tuple "a_b" "A_B"
          ]
    Assert.equal
      "FOO-BAR:A_B"
      (TemplateString.template "{{foo-bar}}:{{a_b}}" obj3)
