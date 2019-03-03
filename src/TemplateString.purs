-- copy from https://github.com/bouzuya/create-b/blob/c36fea382bdd21968fdb005c1eba54f5b2db207a/src/TemplateString.purs
module TemplateString
  ( template
  ) where

import Data.Array as Array
import Data.Either as Either
import Data.Maybe as Maybe
import Data.String.Regex as Regex
import Data.String.Regex as String
import Data.String.Regex.Flags as RegexFlags
import Foreign.Object (Object)
import Foreign.Object as Object
import Partial.Unsafe as Unsafe
import Prelude (bind)

pattern :: String.Regex
pattern =
  Unsafe.unsafePartial
    (Either.fromRight
      (Regex.regex "\\{\\{([a-zA-Z][-_a-zA-Z0-9]*)\\}\\}" RegexFlags.global))

template :: String -> Object String -> String
template tmpl obj =
  Regex.replace'
    pattern
    (\s m -> Maybe.fromMaybe s do
      key <- Array.index m 0
      Object.lookup key obj)
    tmpl
