{-# LANGUAGE TemplateHaskell #-}
module Heos.Browse.GetMusicSources
( --getMusicSources
) where

import           Data.Aeson.TH
import           Data.Aeson.Types   (Value)
import           Heos.Player.Player (Player (pid))
import           Heos.Response      (Response)
import           Network.Connection

{-# ANN module "HLint: ignore Use camelCase" #-}
data Source = Source
  { name      :: String
  , image_url :: String
  , type'     :: Maybe String --TODO parse the field "type" (reserved word)
  , sid       :: Int
  } deriving (Eq,Show)

$(deriveJSON defaultOptions ''Source)

--TODO
--getMusicSources :: Connection -> IO (Response [Source])
--getMusicSources = get "heos://browse/get_music_sources"
