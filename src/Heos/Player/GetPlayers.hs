{-# LANGUAGE TemplateHaskell #-}
module Heos.Player.GetPlayers
( getPlayers
, getPlayerByName
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

--IO functions
getPlayers :: Connection -> IO (Response [Data])
getPlayers = get "heos://player/get_players"

getPlayerByName :: String -> Connection -> IO (Maybe Data)
getPlayerByName v = fmap (playerByName v) . getPlayers
getPlayerByPid :: Int -> Connection -> IO (Maybe Data)
getPlayerByPid v = fmap (playerByPid v) . getPlayers
getPlayersByGid :: Maybe Int -> Connection -> IO [Data]
getPlayersByGid v = fmap (playersByGid v) . getPlayers
getPlayersByNetwork :: String -> Connection -> IO [Data]
getPlayersByNetwork v = fmap (playersByNetwork v) . getPlayers


--Pure functions
playerByName :: String -> Response [Data] -> Maybe Data
playerByName = playerByField name

playerByPid :: Int -> Response [Data] -> Maybe Data
playerByPid = playerByField pid

playersByGid :: Maybe Int -> Response [Data] -> [Data]
playersByGid = playersByField gid

playersByNetwork :: String -> Response [Data] -> [Data]
playersByNetwork = playersByField network

playersByField :: Eq a => (Data -> a) -> a -> Response [Data] -> [Data]
playersByField field value = filter ((== value) . field) . getData

playerByField :: Eq a => (Data -> a) -> a -> Response [Data] -> Maybe Data
playerByField field value = find ((== value) . field) . getData

getData :: Response [Data] -> [Data]
getData response = case payload response of
  Just p -> p
  _      -> []
