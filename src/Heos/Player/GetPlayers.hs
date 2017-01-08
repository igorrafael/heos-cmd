{-# LANGUAGE TemplateHaskell #-}
module Heos.Player.GetPlayers (getPlayers) where

import           Data.Aeson.TH
import           Heos.Connection    (get)
import           Heos.Response      (Response)
import           Network.Connection

data Payload = Payload
    { name    :: String
    , pid     :: Int
    , gid     :: Maybe Int
    , model   :: String
    , version :: String
    , ip      :: String
    , network :: String
    , lineout :: Int
    , control :: Maybe Int
    } deriving (Show, Eq)

$(deriveJSON defaultOptions ''Payload)

getPlayers :: Connection -> IO (Response Payload)
getPlayers = get "heos://player/get_players"
