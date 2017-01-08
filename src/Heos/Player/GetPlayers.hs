{-# LANGUAGE TemplateHaskell #-}
module Heos.Player.GetPlayers (getPlayers) where

import           Data.Aeson.TH
import           Heos.Connection    (get)
import           Heos.Response      (Response)
import           Network.Connection

data Payload = Payload
    { name    :: String
    , pid     :: Int
    --,gid :: Int --TODO support this optional field
    , model   :: String
    , version :: String
    , ip      :: String
    , network :: String
    --,control :: Int --TODO support this optional field
    , lineout :: Int
    } deriving (Show, Eq)

$(deriveJSON defaultOptions ''Payload)

getPlayers :: Connection -> IO (Maybe Response)
getPlayers = get "heos://player/get_players"
