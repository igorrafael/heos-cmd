{-# LANGUAGE TemplateHaskell #-}
module Heos.Player.GetPlayers (getPlayers, getPlayerByName) where

import           Control.Monad
import           Data.Aeson.TH
import           Heos.Connection    (get)
import           Heos.Response      (Response, payload)
import           Network.Connection

data Data = Data
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

$(deriveJSON defaultOptions ''Data)

getPlayers :: Connection -> IO (Response [Data])
getPlayers = get "heos://player/get_players"

getPlayerByName :: String -> Connection -> IO Data
getPlayerByName name = fmap (selectByName name) . getPlayers

selectByName :: String -> Response [Data] -> Data
selectByName n = head . filter (\d -> n==name d) . getData

getData :: Response [Data] -> [Data]
getData response = case payload response of
  Just p -> p
  _      -> []
