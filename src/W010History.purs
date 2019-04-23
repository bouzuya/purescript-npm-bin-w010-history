module W010History
  ( W010History
  , format
  , parse
  ) where

import Bouzuya.TemplateString as TemplateString
import Data.Array as Array
import Data.Maybe (Maybe)
import Data.Maybe as Maybe
import Data.String as String
import Data.Tuple (Tuple(..))
import Foreign.Object (Object)
import Foreign.Object as Object
import Prelude (map, mempty, show, (<<<), (<>))
import Simple.JSON as SimpleJSON

type W010History =
  { yearWeek :: String
  , mockmockDevNo :: Int
  , mockmockDevUrl :: String
  , note :: String
  , beginThreadUrl :: String
  , endThreadUrl :: String
  , repositoryFullName :: String
  , date010 :: Maybe String
  , date100 :: Maybe String
  }

format :: Array W010History -> String
format histories = String.joinWith "\n" (map toString histories)

parse :: String -> Maybe (Array W010History)
parse = SimpleJSON.readJSON_

templateString :: String
templateString =
  String.joinWith
    "\n"
    [ "- {{yearWeek}}"
    , "  - [mockmock.dev #{{mockmockDevNo}}]({{mockmockDevUrl}})"
    , "  - {{note}}"
    , "  - [やること宣言]({{beginThreadUrl}})"
    , "  - [やったこと成果発表]({{endThreadUrl}})"
    , "  - [{{repositoryFullName}}](https://github.com/{{repositoryFullName}})"
    , "  - v0.1.0 ([{{date010}}]({{date010Url}}))"
    , "  - v1.0.0 ([{{date100}}]({{date100Url}}))"
    ]

toBlogUrl :: String -> String
toBlogUrl s =
  "https://blog.bouzuya.net/" <>
    (String.replaceAll (String.Pattern "-") (String.Replacement "/") s) <>
    "/"

toObject :: W010History -> Object String
toObject h =
  Object.fromFoldable
    ( [ Tuple "mockmockDevNo" (show h.mockmockDevNo)
      , Tuple "mockmockDevUrl" h.mockmockDevUrl
      , Tuple "note" h.note
      , Tuple "beginThreadUrl" h.beginThreadUrl
      , Tuple "endThreadUrl" h.endThreadUrl
      , Tuple "repositoryFullName" h.repositoryFullName
      , Tuple "yearWeek" h.yearWeek
      ] <>
      (Maybe.maybe
        mempty
        (Array.singleton <<< (Tuple "date010"))
        h.date010) <>
      -- FIXME
      (Maybe.maybe
        mempty
        (Array.singleton <<< (Tuple "date010Url") <<< toBlogUrl)
        h.date010) <>
      (Maybe.maybe
        mempty
        (Array.singleton <<< (Tuple "date100"))
        h.date100) <>
      -- FIXME
      (Maybe.maybe
        mempty
        (Array.singleton <<< (Tuple "date100Url") <<< toBlogUrl)
        h.date100))

toString :: W010History -> String
toString h = TemplateString.template templateString (toObject h)
