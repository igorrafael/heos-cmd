{-# LANGUAGE TemplateHaskell #-}
module Heos.Player.GetPlayers
( getPlayerByName
, getPlayerByPid
, getPlayersByGid
, getPlayersByNetwork
) where

import           Control.Monad
import           Data.Aeson.TH
import           Data.List
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

getPlayerByName :: String -> Connection -> IO (Maybe Data)
getPlayerByName = getPlayerByField name

getPlayerByPid :: Int -> Connection -> IO (Maybe Data)
getPlayerByPid = getPlayerByField pid

getPlayersByGid :: Maybe Int -> Connection -> IO [Data]
getPlayersByGid = getPlayersByField gid

getPlayersByNetwork :: String -> Connection -> IO [Data]
getPlayersByNetwork = getPlayersByField network

getPlayersByField :: Eq a => (Data -> a) -> a -> Connection -> IO [Data]
getPlayersByField field value = fmap filtered . getPlayers
  where
    filtered = filter ((== value) . field) . getData

getPlayerByField :: Eq a => (Data -> a) -> a -> Connection -> IO (Maybe Data)
getPlayerByField field value = fmap first . getPlayers
  where
    first = find ((== value) . field) . getData

getData :: Response [Data] -> [Data]
getData response = case payload response of
  Just p -> p
  _      -> []
