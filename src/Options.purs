module Options
  ( Options
  , parse
  ) where

import Bouzuya.CommandLineOption (OptionDefinition)
import Bouzuya.CommandLineOption as CommandLineOption
import Data.Either as Either
import Data.Maybe (Maybe(..))
import Prelude (map)

type Options =
  { help :: Boolean }

defs ::
  { help :: OptionDefinition Boolean }
defs =
  { help: CommandLineOption.booleanOption "help" (Just 'h') "show help" }

parse :: Array String -> Maybe Options
parse args = map _.options (Either.hush (CommandLineOption.parse defs args))
